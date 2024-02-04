import Config

config :nx,
  default_backend: EXLA.Backend

config :cat_in_da_car, :telegram,
  token: System.get_env("TELEGRAM_TOKEN"),
  chat_id: System.get_env("TELEGRAM_CHAT_ID")
