import Config

config :ui, UIWeb.Endpoint,
  server: true,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ]

config :accounts, Accounts.Authentication,
  issuer: "sg-sports-line",
  secret_key: System.get_env!("AUTH_SIGNING_KEY")
