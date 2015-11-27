require 'spec_helper.rb'

describe TreeBuilder do
    def node(name, children=nil)
    CategoryNode.new(name, children)
  end

  describe '#build' do
    it 'should build a tree from a single category' do
      root = subject.build("Home")

      expect(root.name).to eq("All")
      expect(root.children).to include(node("Home"))
    end

    it 'should build a tree from a two-level category' do
      root = subject.build("Home > Bath")

      expect(root.children).to include(node("Home", [node("Bath")]))
    end

    it 'should build a tree from a three-level category' do
      root = subject.build("Home > Bath > Towels")

      expect(root.children).to include(node("Home", [node("Bath", [node("Towels")])]))
    end

    it 'should build a tree with multiple top level categories' do
      root = subject.build("Home > Bath\nClothing > Women's")

      expect(root.children).to include(node("Home", [node("Bath")]))
      expect(root.children).to include(node("Clothing", [node("Women's")]))
    end

    it 'should merge trees with the same top level node' do
      root = subject.build("Home > Bath\nHome > Garden")

      expect(root.children).to include(node("Home", [node("Bath"), node("Garden")]))
    end

    it 'should merge a subtree into a sub category of a top level' do
      root = subject.build("Home > Bath > Towels,6\nHome > Bath > Shower,4")

      expect(root.children).to include(node("Home", [node("Bath", [node("Towels"), node("Shower")])]))
    end

  end

end
