%{
  title: "Adding password security to Hex.pm",
  author: "Todd Resudek",
  tags: ~w(elixir),
  description: "Adding haveibeenpwned analysis to hex.pm"
}
---

![warning image](images/hibp-title.png)
<figcaption>The warning you’ll see when your password has been breached.</figcaption>

<br />

As maintainers of a package manager, we are constantly balancing our efforts across feature requests, bug tickets, technical support and documentation improvements. But perhaps more important of all is our obligation to security.

There are many security vectors for package managers. As a team, we are constantly looking for solutions to eliminate or at least mitigate them.

Recently I worked on one such solution. In this case, the security issue is from insecure passwords. It is important to note that “insecure” doesn’t necessarily mean a password that is short, or easily guessable. It could also be a password that has been used on more than one site.

## So, what’s the issue with a weak password?

Since Hex makes releases immutable (except for the first hour after publishing) an issue like [leftpad](https://www.google.com/search?client=firefox-b-1-d&q=left+pad+npm) won’t happen on Hex. While you cannot take down your existing releases, one thing that can happen is to have a bad actor publish a release as you which contains malicious code.

While it is good practice to audit the changes in each package you are updating (and we have tools to make it easier), it is also unrealistic to think everyone takes the time to do that.

The better solution is to prevent a bad actor from gaining access to your Hex account in the first place.

## Determining when an account is at risk.

The first step to alerting our users is to determine if their account is at risk. To do this, we are using the [haveibeenpwned API](https://haveibeenpwned.com/API/v2#PwnedPasswords).

This API was developed and maintained by developer Troy Hunt. He does this at his own expense for the benefit of the entire web 👏. The API provides a very simple interface; It is not rate-limited, and no authentication is required.
![API example](images/hibp-terminal.gif)
<figcaption>Example response from haveibeenpwned.com</figcaption>

<br />

## How Hex.pm checks your password

As a practical matter, the haveibeenpwned API needs to have access to un-hashed passwords. The only way to know if your password was breached is to check it before it is encrypted. (Technically, passwords are passed around the API as SHA1 hashes, which obscure your password.)

Since Hex never stores your password in a way that would allow us to decrypt it, we cannot just check every password in our database for breaches. (This is a good thing!) As a result, checking your password for weakness can only happen when you submit it in a form. This happens to be when you log in, and when you reset your password.

In each event, while in the form controller, we check your password against the haveibeenpwned API. If we have determined your password has been breached, we add a flash warning.
![code](images/hibp-code.png)
<figcaption>Code for checking passwords</figcaption>

<br />

## UX decisions

Philosophically, the Hex team discussed how to treat weak passwords. On one end of the spectrum we could not check password strength at all (not have a minimum number of characters, etc.) On the other end, we could verify the password strength and prevent users from logging in until they have changed to a stronger password.

Our approach is decidedly lenient for the time being. While we do show a warning, we only show that on the next page view. We do not hound you while you are on the site. We do not send you an email reminder.

In fact, you’ll see in our code we only allow the API request to block for 500ms before timing out. Meaning, if the API slows down our login process too much, we will forgo the strength check at that time.

## In conclusion

We hope adding features like this will encourage Hex users to build better habits. Security will always be one of our commitments to the Elixir and Erlang communities.