import Config

config :terraria_bot,
  log_file: "/current.log"

import_config "#{config_env()}.exs"
