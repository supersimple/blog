%{
  title: "The Elixir Version Module",
  author: "Todd Resudek",
  tags: ["elixir"],
  description: "Details on the Elixir version module"
}
---
There are a few modules in the [Elixir stdlib](https://hexdocs.pm/elixir/Kernel.html) that everyone is familiar with. Modules like Enum, Map, and String are used so frequently they have earned a certain level of ubiquity.

If you dig a little deeper, you will find a few specialized modules. Ones with names like [Path](https://hexdocs.pm/elixir/Path.html#content), and [Port](https://hexdocs.pm/elixir/Port.html#content), and the one we are focusing on in this article — [Version](https://hexdocs.pm/elixir/Version.html#content).

The module definition is pretty straightforward:

_Functions for parsing and matching versions against requirements._

---

Before going any further, it is important to mention this module expects and relies on the versions to follow the [SemVer 2.0 schema](http://semver.org/).

While the semantic versioning schema lists a whole host of recommendations, there are 2 that are particularly important:

1. Versions are defined in Major.Minor.Patch format
2. A pre-release version starts with a hyphen. eg. 4.1.0-alpha.1

---

The version module works with 2 types of data; Version structs, and requirements.

## Version Structs

Versions can be created by passing a string into the `parse!/1` or `parse/1` functions. If the string does not match a valid semantic version format, you will get an **InvalidVersionError**.

![code](images/version-code1.png)

A version struct contains 5 attributes: _major, minor, patch, pre, and build_.

![code](images/version-code2.png)

## Requirements

Requirements allow you to specify which versions of a given dependency you are willing to work against. Requirements support operators like: `~>, ==, >=, <=, >`.

![code](images/version-code3.png)

You can create a requirement by using the `parse_requirement/1` function.

![code](images/version-code4.png)

## What is the Version module used for?

One reason for using the Version module is to compare two semantic versions. Here is an example of the `compare/2` function being used in a very popular piece of Elixir software:

![code](images/version-code5.png)

In this example, you can see that the system Elixir version is compared to 1.4.0. The return from that function is always one of: `:gt :eq :lt`. So, this code specifically checks to see if the installed Elixir version is less than 1.4, and if so uses the `Enum.partition/2` function. That function was deprecated in 1.4 and replaced with `Enum.split_with/2`, which is what is used in the `else` block.

The other reason the Version module is used is to see if a version matches a requirement. Here is an example:

![code](images/version-code6.png)

The Version module is pretty small, and has a limited number of use cases. But when you find yourself trying to deal with version numbers, you will be glad you know about it.