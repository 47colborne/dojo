defmodule FullTextSearchIndexTest do
  use ExUnit.Case
  alias FullTextSearch.Index

  setup do
  	FullTextSearch.Index.start_link
  	{:ok, []}
  end

  describe "index_document" do
  	test "it updates the inverted index with the given document_id and text" do
  		
  		Index.index_document("abc def", "1")
  		state = Agent.get(Index, fn state -> state end)
  		assert state == %{"abc" => MapSet.new(["1"]), "def" => MapSet.new(["1"])}
  	end

  	test "it handles multiple document_ids for a single term" do
  		Index.index_document("abc def", "1")
  		Index.index_document("abc", "2")
  		state = Agent.get(Index, fn state -> state end)
  		assert state == %{"abc" => MapSet.new(["1", "2"]), "def" => MapSet.new(["1"])}
		end
  end
end
