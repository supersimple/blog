%{
  title: "Engineering at SimpleBet: Year One",
  author: "Todd Resudek",
  tags: ~w(elixir),
  description: "Recap of my first year working at SimpleBet"
}
---
## Why SimpleBet?
Before recapping my first year of work, it is important to talk about how I came to [SimpleBet](https://simplebet.io) in the first place.

Previously, I worked as an Elixir engineer at [Weedmaps](https://weedmaps.com). I was there for 3.5 years and had a lot of great opportunities and met a lot of great people. However, I felt like I was starting to stagnate a little and wanted to work on a project that would challenge me more.

I interviewed at a number of places, but ultimately there were a few things SimpleBet offered that intrigued me.

I liked that I would still be working in a domain that was recently legalized and did not yet have market leaders or even existing solutions. Working in those domains, there is no one to copy. There is no saying, "how does xyz do it?"

I also liked the constraints of the product. Most betting on sports is on the outcome of an entire match. You place your bet and the market is settled 2 or 3 hours later. SimpleBet offers micro-markets that open and settle within seconds. For example, betting on whether the next pitch will be a ball or a strike.

I knew these constraints would require me to carefully consider design decisions. Making round trips to postgres isn't possible for a lot of what SimpleBet does. It requires a lot of coordination of systems and a lot of observeability to get right.

Finally, the team I met while interviewing were a great group of smart people, from different backgrounds that I knew I could learn from. SimpleBet has a mix of PhD's and bootcamper's and everything in between.

## January 7, 2020

My first day at SimpleBet.

_([My work computer](https://sprsm.pl/xps13) was sent to me the week before, so I was able to set that up in advance.)_

I woke up earlier than usual since the office is 2 time zones ahead of me. As it turns out the engineer that was going to help onboard me actually 4 time zones ahead, so he was waiting. The first couple weeks were spent getting familiar with the domain and the existing code.

I spent my 3rd week at the SimpleBet offices in New York City. My teammates from Idaho, Ireland,  and Uruguay flew in as well, so we were able to meet and kick off our first project. I can't discuss specifics of the project, but we began immediately using Phoenix LiveView. It was exactly what I was looking for  - a greenfield project that was using cutting-edge technologies.

> If it isn't obvious, we really like the BEAM at SimpleBet.

## February and March

Before accepting my offer I had already been accepted to speak at 3 conferences in the spring. I talked to my would-be boss about those demands on my schedule while I was interviewing. As it turns out, he was accepted to speak at one of those conferences as well.

The first conference of the year was [Empex LA](https://www.youtube.com/watch?v=mJb9wjUJhm4), on February 8. I was able to give a talk I have been wanting to give for a while on the virtues of Erlang.

The next conference was [Lonestar Elixir](https://www.youtube.com/watch?v=BatvEJg5Vsg), in Austin, where I talked about designing and building a hardware project using Nerves.

Finally, I spoke at [CodeBEAM SF](https://www.youtube.com/watch?&v=Gt6tough35c) along with my colleague, [Dave Lucia](https://github.com/davydog187/).

I always enjoy speaking at conferences, and it was great to be able to represent SimpleBet to the Elixir community.

I was also able to spend some time launching our Open-Source Software guild at work, and deploying our [TIL instance](https://til.simplebet.io). One of the parts I enjoy most about SimpleBet is how much value is placed on contributing to OSS. I am able to spend time on Hex, and my co-workers are maintainers of Rustler, Commanded, and a lot of the Telemetry libraries.

## COVID-19

Corona virus has affected all of us tremendously to be sure. While acknowledging the toll it has taken on us as humans, I want to focus how it specifically effected our business.

All of our work to this point has been spent focusing on Major League Baseball products. Due to the virus, MLB delayed the season without any specific idea on when or if it would resume. 

It's hard to build a sports gaming business for a sport that isn't being played. Leadership had to consider the viability of our business if no sports were being played until 2021. As a result, a lot of good people were let go :( as we reorganized for the new reality.

## Visualization Tools

My team immediately shifted our focus onto a product that would serve both as an internal broker for any sport, as well as a way for potential customers to visualize what SimpleBet offers.

It was another greenfield project, and a chance to work with some new technologies and get reacquainted with some familiar ones. We started with [Tailwind CSS](https://tailwindcss.com), which is great. Along with LiveView for the UI layer. On the backend, the broker aggregated all of our machine learning pricing into a unified RabbitMQ broker. (If it isn't obvious, we really like the BEAM at SimpleBet.)

## All in on Football

Based on the information coming out of league offices, the decision was made to go all-in on our NFL products. So, in late-spring I joined an existing team that was building an app for football.

The app consists of 2 parts; the Elixir/Phoenix back-end, and the Dart/Flutter front-end. I have been almost-exclusively working on the Elixir side of the project.

A big part of this project has been observeability. We have been using [Lightstep](https://lightstep.com) along with the Elixir and Erlang telemetry libraries to get insights into how well our app performs. It's been amazing to get detailed reports on what code is slowing our app, being able to improve the code and watching the performance improve.

---

If you imagine a football team in a hurry-up offense, that means we have maybe 15 seconds to:
- get the current state of the game (from observers at the stadium.)
- apply our ML models to the state to generate odds for each outcome
- send those odds across the message broker to our app
- display the odds
- take bets from our users
- get the message that the ball has been snapped and close those betting markets.

Any slowdown in the system and the user experience degrades significantly. 

---

We were able to launch the app for week 1 of the NFL, called PlayAction, which you can find in the [Fanduel](https://fanduel.com) app. It really makes for a great second-screen experience. So far it has been a great success, and something I think everyone at SimpleBet is really proud of.

## Tip-off of NBA

It has been a crazy year for sports. Normally the NBA finals would end at the beginning of June and there would be a 5 month off-season. This year, the NBA finals ended on October 11. While we were all unsure when the 2021 season would start, we all knew it would be fast-approaching.

While we have still been improving the NFL app, my team started working on adding the NBA in October. The goal was to have a working app by the team the NBA preseason started on December 11 (only 2 months!)

I am happy to say we have a Beta version of the NBA app available now on Fanduel which was available for the opening tip of the NBA season.

## What's Next?
It's been a long year. Hopefully in 2021 I am able to keep working on our existing apps and we continue to expand our offerings. If you are interested in what we are doing, check out our [jobs page](https://jobs.lever.co/simplebet). Or follow us on Twitter: @simplebetHQ and @sb_engineers.