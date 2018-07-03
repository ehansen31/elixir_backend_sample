# ElixirBackendSample

Sample project to be used going forward as a baseline api for quick POC's and other projects that involve rapid prototyping. Designed to be forked so that business logic can be immediately written into the codebase with the boilerplate complete. Could also serve as a hackthon boilerplate. Intended to kickstart the consulting + dev shop work I would like to be involved with in the future.


## Features include:
* Elixir functional programming language
* Phoenix web server and framework
* Absinthe GraphQL library
* ecto + postgrex for data models, migrations, and seeds
* Guardian user token creation and validation through _authorization_ header in api requests
* Password hashing into database via comeonin + bcrypt
* bamboo for password recovery emails
* unit testing + test driven development ready
* dockerfile to create a deployable container ready for ECS
* aws deployment with elastic beanstalk, push button deployment from command line and ci ready
* Distillery to create standalone deployables for usage outside of mine ie. handoff

### project settings


### config files changes
* postgres database changes

### To deploy:
  1. install aws eb cli
  2. `cd` into project directy and run `eb create`
  3. run `eb deploy` to deploy changes to the server

---
---


To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
