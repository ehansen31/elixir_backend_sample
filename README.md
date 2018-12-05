# ElixirBackendSample

Sample project to be used going forward as a baseline API for quick POC's and other projects that involve rapid prototyping. Designed to be forked so that business logic can be immediately written into the codebase with the boilerplate complete. Could also serve as a hackathon boilerplate.

---
#### TODO:
* add logging
* postgres jsonb document store capabilities
* unit test mock database populated on run time


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
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`
  * GraphQL listings at [http://localhost:4000/api/graphiql](http://localhost:4000/api/graphiql)
  * Unit tests with `MIX_ENV=test mix test`

### To deploy:
  1. Configure `prod.secret.exs` with database, smtp, and secret key (`mix guardian.gen.secret`).
  2. Install AWS EB CLI [instructions](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install.html)
  3. `cd` into project directy and run `eb create`
  4. Run `eb deploy` to deploy changes to the server
