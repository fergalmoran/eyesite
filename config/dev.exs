import Config

config :pingsite, PingSite.Repo,
  username: "postgres",
  password: "hackme",
  hostname: "localhost",
  database: "pingsite_dev",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :pingsite, PingSiteWeb.Endpoint,
  phoenix_profiler: [server: PingSite.Profiler],
  https: [
    port: 4000,
    cipher_suite: :strong,
    keyfile: "/etc/letsencrypt/live/dev.pingsite.io/privkey.pem",
    cacertfile: "/etc/letsencrypt/live/dev.pingsite.io/chain.pem",
    certfile: "/etc/letsencrypt/live/dev.pingsite.io/cert.pem"
  ],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "HsIGy4itgDIqyg66sVmJubuO88yv5BUlRR+QpeF1B+Z7KZnlZ4VeKkegkLEiUGnk",
  watchers: [
    # Start the esbuild watcher by calling Esbuild.install_and_run(:default, args)
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:default, ~w(--watch)]}
  ]

# Watch static and templates for browser reloading.
config :pingsite, PingSiteWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/pingsite_web/(live|views)/.*(ex)$",
      ~r"lib/pingsite_web/templates/.*(eex)$"
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
