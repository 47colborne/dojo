defmodule FullTextSearchSearchTest do
	use ExUnit.Case
  alias FullTextSearch.Search

  describe "single term search" do
		setup do
	  	FullTextSearch.Index.start_link(%{
	  		"term1" => MapSet.new(["document1"])
	  	})
	  	{:ok, []}
	  end

  	test "it returns the document_id with matched term" do
  		assert Search.search("term1") == MapSet.new(["document1"])
  	end

  	test "it returns [] with unmatched term" do
  		assert Search.search("nonexistent") == MapSet.new([])
  	end
  end
  
  describe "multiple term search" do
		setup do
	  	FullTextSearch.Index.start_link(%{
	  		"term1" => MapSet.new(["document1", "document2"]),
	  		"term2" => MapSet.new(["document2"]),
	  		"term3" => MapSet.new(["document2"])
	  	})
	  	{:ok, []}
	  end

  	test "it returns document2 since it has all terms" do
  		assert Search.search("term1 term2") == MapSet.new(["document2"])
  	end

  # 	test "it works for more than 2 terms" do
		# 	assert Search.search("term1 term2 term3") == MapSet.new(["document2"])
		# end
  end	
end