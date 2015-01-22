defmodule CORS do
  import Plug.Conn

  def headers do
    [
      {"Access-Control-Allow-Origin", "*"},
      {"Access-Control-Allow-Methods", "GET, OPTIONS"},
      {"Access-Control-Allow-Headers", "accept, accept-encoding, accept-language, content-language, last-event-id, content-type, authorization"}
    ]
  end

end
