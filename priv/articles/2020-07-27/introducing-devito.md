%{
  title: "Introducing Devito",
  author: "Todd Resudek",
  tags: ~w(elixir),
  description: "Introducing Devito - an open source link shortener written in Elixir."
}
---
Today I’d like to introduce an open-source software project I have been working on named [Devito](https://trydevi.to).

[Devito](https://trydevi.to) is a URL-shortener that comes out-of-the-box ready for deployment to [Gigalixir](https://gigalixir.com/). What makes [Devito](https://trydevi.to) special is that it is designed to work with it’s own CLI. No browser plugins. No web-app. Everything you need is accessible right through your terminal.

![Devito loves Elixir](images/devito+elixir.png)
<figcaption>Devito ❤️ Elixir</figcaption>

## The Interface

All actions for [Devito](https://trydevi.to) can be performed through the CLI, and that is the recommended interface. After setting your configs, you will mostly want to generate links or see existing links. Here is what that looks like:
![Sample Code](images/devito-code1.png)
<figcaption>setting the config</figcaption>

![Sample Code](images/devito-code2.png)
<figcaption>generating a link with a random shortcode</figcaption>

![Sample Code](images/devito-code3.png)
<figcaption>generating a link with a custom shortcode</figcaption>

![Sample Code](images/devito-code4.png)
<figcaption>Viewing all existing links</figcaption>

## Why Gigalixir?

Gigalixir is a hosting service designed for Elixir. They offer a service free tier that fits this project well, and generally, the product is easy to work with. Having said that, deployment is based on buildpacks, so it should be easy to deploy [Devito](https://trydevi.to) to Heroku or a similar service without much extra effort.

## Why a CLI?

[Devito](https://trydevi.to) is designed for developers. While other shorteners use browser plugins, I never found them ergonomic. They require signing in periodically, and sometimes the plugins are available for your browser and sometimes not. And it takes 2 or more steps to make a custom link.

## Try It Out

I’d love for you to try it out and let me know what you think. Visit [trydevi.to](htts://trydevi.to) to get started.