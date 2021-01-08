%{
  title: "When a Changeset is a Plug",
  author: "Todd Resudek",
  tags: ~w(elixir),
  description: "Identifying code taht could be in changesets that would be better in a plug."
}
---
![plug](images/plug.png)

I recently ran into this error on a project I have been working on:
![code](images/plug-code1.png)
<figcaption>error message</figcaption>

<br />

It seems a user incorrectly entered a URL, replacing what should be a UUID with a regular binary. It could be a path that has changed, or a bad inbound link, or just a typo.

As a result of this error not being correctly intercepted, the user is bound to get a 500 error back. Not only is that frustrating, but it is also incorrect. The user should get some indication that the URL is malformed and it will never work.

Typically in Phoenix I will use a changeset to validate incoming requests. In this case the path names that parameter `:project_id`. The controller would cast that parameter and use a validator function to insure it is a correctly formed UUID. If it isn’t, it will return a changeset error.

The problem is this project has 40 routes that expect UUIDs, spread across 15 controllers. Adding changeset validations to all of those controllers and actions will take a lot of time and effort.

I decided to take another approach. Since the parameters I want to validate are all named `:id` or `:project_id` I thought I could validate them with a plug. The plug is used in the pipeline for every request and looks like this:
![code](images/plug-code2.png)
<figcaption>plug code</figcaption>

<br />

As you can see, the plug analyzes the conn for params named either `:id` or `:project_id`. When it finds one, it attempts to cast it’s value to a UUID. If that returns an error, the conn is halted and a view with a 422 status code is returned. The error message is explanatory of the actual issue.

You see, sometimes what you think is a changeset actually turns out to be a plug.