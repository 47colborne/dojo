defmodule FullTextSearch.Index do
	def start_link(state \\ %{}) do
		Agent.start_link(fn -> state end, name: __MODULE__)
	end

	# client functions
	def index_document(text, document_id) do
		text
		|> String.split
		|> Enum.each(&(insert_term(&1, document_id)))

		:ok
	end

	defp insert_term(term, document_id) do
		Agent.update(__MODULE__, fn state ->
			Map.update(state, term, MapSet.new([document_id]), fn set -> 
				MapSet.put(set, document_id)
			end)
		end)
	end
end
