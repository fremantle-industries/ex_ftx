use Mix.Config

config :ex_ftx,
  api_key: System.get_env("FTX_API_KEY"),
  api_secret: System.get_env("FTX_API_SECRET")

config :exvcr,
  filter_request_headers: [
    "FTX-KEY",
    "FTX-SIGN",
    "FTX-TS"
  ],
  filter_sensitive_data: [
    [pattern: "username\":\"[a-zA-Z0-9@.]+\"", placeholder: "username\":\"***\""],
    [pattern: "id\":[0-9]+", placeholder: "id\":123"]
  ],
  response_headers_blacklist: [
    "Set-Cookie",
    "account-id",
    "ETag",
    "cf-request-id",
    "CF-RAY"
  ]
