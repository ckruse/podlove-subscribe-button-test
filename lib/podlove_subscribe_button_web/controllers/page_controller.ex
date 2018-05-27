defmodule PodloveSubscribeButtonWeb.PageController do
  use PodloveSubscribeButtonWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def feed(conn, params) do
    url = "#{conn.scheme}://#{conn.host}#{non_standard_port(conn)}#{conn.request_path}"
    render(conn, "feed.xml", url: url, page: present?(params["page"]))
  end

  defp non_standard_port(conn) do
    if (conn.scheme == "http" && conn.port != 80) || (conn.scheme == "https" && conn.port != 443),
      do: ":#{conn.port}",
      else: ""
  end

  defp blank?(nil), do: true
  defp blank?(""), do: true
  defp blank?(0), do: true
  defp blank?([]), do: true
  defp blank?(%{} = map) when map == %{}, do: true
  defp blank?(_), do: false

  defp present?(v), do: !blank?(v)
end
