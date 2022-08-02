%{
  title: "Building Your First Hex Package",
  author: "Todd Resudek",
  tags: ["elixir", "hex"],
  description: "How to build and publish a hex package"
}
---

![code](../images/first-title.png)

<br />

As a full-time rubyist, I rely on open-source libraries on a daily basis to do my work. And, like many other ruby programmers lately, I have taken an interest in elixir. So, as I started learning more about the elixir ecosystem I had a question; what is the elixir version of rubygems?

As it turns out, elixir has a very similar analog to gems called “hex”. Just as you would search for ruby gems on rubygems.org, or node packages on npmjs.com, you can find packages for the erlang ecosystem on hex.pm.

As of this writing, there are about 3,600 hex packages available on hex.pm. That might not seem like a lot compared to rubygems (about 100,000 gems) or npm (over 750,000), but interest in erlang and elixir is a much more recent phenomenon. I would expect that number to rise in the coming months and years.

---

## Getting Started

First things first, you need to install hex on your machine. If you have elixir installed, chances are you already have it. (If not, go to http://elixir-lang.org/install.html ) You can check by typing: `mix hex -v` you should get an output like this:

![code](../images/first-code1.png)
<figcaption>mix hex -v</figcaption>

<br />

If you do not have hex installed, type: `mix local.hex` to install it.

---

## Create an Account

You will need an account on hex.pm before you’ll be able to submit your package. Type: `mix hex.user register` to begin the registration process. Just enter your email address, select a username, and a password. You will be emailed to confirm your account. Once your account is confirmed, you will be ready to submit packages.

## Choose a Name

There are very few rules when selecting a name for your hex package. In fact, the only real rule is:

> Avoid using offensive or harassing package names, nicknames, or other identifiers that might detract from a friendly, safe, and welcoming environment for all.

That being said, there are some names that are better than others. For instance, if your package extends the functionality of another library, use that library name as a prefix. (eg. If you are adding xml parsing to the Poison json package, a good name would be “poison_xml”.)

If you are porting a library from another ecosystem, it is common to prepend (or less commonly append) “_ex” to that library’s name. (eg. The aws rubygem is called “ex_aws” in hex. There is a Spotify package named “spotify_ex”.)

## Create an Empty Project

Time to start writing code. To start, type: `mix new <yourprojectname>` . You should see an output like this:

![code](../images/first-code2.png)
<figcaption>mix new</figcaption>

<br />

## Adding Metadata to Your Package

Metadata will help define your package dependencies as well as describe it to potential users. Open your `mix.exs` file and you’ll see a template like this:

![code](../images/first-code3.png)
<figcaption>mix.exs</figcaption>

<br />

_Hex packages are required to follow semantic versioning._

Dependencies are defined in a private method, `deps/0`. This is where you will document any other packages your package requires (if any.) For example, you might want to require ex_doc to generate documentation:

![code](../images/first-code4.png)
<figcaption>mix.exs</figcaption>

<br />

After you add dependencies, you need to type: `mix deps.get` to include them in your project. This is just like adding a gem to your gemfile and typing: `bundle install`.

To learn more about dependencies, type: `mix help deps`.

In addition to the attributes predefined for you in your mix file, you will need to include a description and package information.

![code](../images/first-code5.png)
<figcaption>mix.exs</figcaption>

<br />

## Add a License

I have chosen to publish this package under the GPL 3.0 license. As such, I am required to include the text of that license in a file within the project. You can find the descriptions and full text of open source licenses on https://opensource.org/licenses . The full text should be in a file named `LICENSE.md` and placed at the root of your project.

## Compile Your Project

Assuming you have written your elixir code (in lib/yourprojectname.ex) and tests (in test/yourprojectname_test.exs). You did write tests, didn’t you!? You are ready to compile your package. Type: `mix compile`. This will compile any .ex files and generate documentation files.
Submit Your Package

You are almost there. Now it’s time to submit your package to hex.pm to be shared with the elixir community. Type: `mix hex.publish`. You’ll see some output as it reads your package. **Review it carefully**.

![code](../images/first-code6.png)
<figcaption>mix hex.publish</figcaption>

<br />

Confirm, and your package will be published.

## Congratulations! 🎉

You should see your package on https://hex.pm within a few minutes.
