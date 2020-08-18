import Config

config :db, DB.Repo,
  database: "sg-sports-line-test",
  username: "postgres",
  password: "postgres",
  hostname: System.get_env("DB_HOST", "localhost")
