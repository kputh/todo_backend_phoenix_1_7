# Todo Backend Phoenix 1.7

This is an example implementation of a [todo backend](https://todobackend.com/) using [Phoenix framework](https://www.phoenixframework.org/) 1.7, [Ecto](https://hexdocs.pm/ecto/) 3.10 and [Elixir](https://todobackend.com/) 1.16.

Steps to project completion:

1. [x] implement ToDo API
2. [ ] deploy backend
3. [ ] adjust CORS headers
4. [ ] have implementation listed

-------------------------------------------------------------------------------

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Then run `docker compose up -d` to start a PostgreSQL service
  * And run `mix ecto.migrate` to apply migrations
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
  * You can verify compliance with the ToDo backend API at https://todobackend.com/specs/index.html?http://localhost:4000/api/todos

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
