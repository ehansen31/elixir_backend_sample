FROM elixir:latest

# Install other stable dependencies that don't change often
# RUN apt install -y nodejs

# Compile app
RUN mkdir /app
WORKDIR /app

COPY . .
# RUN npm install --prefix ./assets
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get

# Install app
ADD . .
RUN mix compile

# Compile assets
# RUN NODE_ENV=production assets/node_modules/brunch/bin/brunch build --production
# RUN MIX_ENV=prod mix phoenix.digest

# Exposes this port from the docker container to the host machine
EXPOSE 4000

# The command to run when this image starts up
CMD MIX_ENV=prod mix ecto.migrate && \
  MIX_ENV=prod mix phoenix.server