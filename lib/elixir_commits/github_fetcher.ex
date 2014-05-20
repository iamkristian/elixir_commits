defmodule ElixirCommits.GithubFetcher do
  def fetch_page(page) do
    body = get(page)
    commits = extract_commits(body)
    commits
  end

  defp extract_commits(body) do
    # Extract all of the commit elements
    for e <- body, do: e["commit"]
  end

  defp get(page) do
    {:ok, 200, _headers, client} = :hackney.get(url_for(page))
    {:ok, body} = :hackney.body(client)
    ExJSON.parse(body, :to_map)
  end

  defp url_for(page) do
    api_url <> page
  end

  defp api_url do
    "https://api.github.com/repositories/1234714/commits?page="
  end
end
