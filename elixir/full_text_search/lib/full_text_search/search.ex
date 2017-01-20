defmodule FullTextSearch.Search do
	alias FullTextSearch.Index

	def search(terms) do
		
		terms
		|> String.split
		|> Enum.map(fn term -> 
			case search_single_term(term) do
				{:ok, matched} -> matched
				:error -> MapSet.new([])
			end
		end)
		|> intersection
	end

	def intersection([]) do
		MapSet.new([])
	end

	def intersection([head | []]) do
		head
	end

	def intersection(result = [ head | [tail] ]) do		
		MapSet.intersection(head, tail)
	end

	defp search_single_term(term) do
		Agent.get(Index, fn state -> Map.fetch(state, term) end)
	end
end
