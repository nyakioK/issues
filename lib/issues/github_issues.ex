defmodule Issues.GithubIssues do
  require Logger

  @user_agent [ {"User-agent", "Elixir nyakiokagure@gmail.com"} ]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    Logger.info("Fetching #{user}'s project #{project}")

    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  @spec handle_response(
          {any,
           %{
             body:
               binary
               | maybe_improper_list(
                   binary | maybe_improper_list(any, binary | []) | byte,
                   binary | []
                 ),
             status_code: any
           }}
        ) ::
          {:error,
           false
           | nil
           | true
           | binary
           | [false | nil | true | binary | [any] | number | map]
           | number
           | %{optional(atom | binary) => false | nil | true | binary | [any] | number | map}}
          | {:ok,
             false
             | nil
             | true
             | binary
             | [false | nil | true | binary | [any] | number | map]
             | number
             | %{optional(atom | binary) => false | nil | true | binary | [any] | number | map}}
  def handle_response({ _, %{status_code: status_code, body: body}}) do
    {
      status_code |> check_for_error(),
      body |> Poison.Parser.parse!()
    }
  end

  defp check_for_error(200), do: :ok
  defp check_for_error(_), do: :error
end
