# ElixirBackendSample

Sample project to be used going forward as a baseline API for quick POC's and other projects that involve rapid prototyping. Designed to be forked so that business logic can be immediately written into the codebase with the boilerplate complete. Could also serve as a hackathon boilerplate.

## Features include:
* Elixir functional programming language
* Phoenix web server and framework
* Absinthe GraphQL library
* Ecto + Postgrex for data models, migrations, and seeds
* Guardian user token creation and validation through `authorization` header in api requests
* Password hashing into database via ComeOnIn + BCrypt
* Bamboo for password recovery emails
* Unit testing + test driven development ready
* Dockerfile to create a portable deployment container
* AWS deployment with Elastic Beanstalk, push button deployment from command line and CI ready
* Distillery to create standalone deployables for use with other deployment strategies

### Up and running
* Follow phoenix directions below
* Unit tests with `MIX_ENV=test mix test`
* Configure `prod.secret.exs` with database, smtp, and secret key (`mix guardian.gen.secret`).

### To deploy:
  1. Install AWS EB CLI [instructions](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html)
  2. `cd` into project directy and run `eb create`
  3. Run `eb deploy` to deploy changes to the server

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
