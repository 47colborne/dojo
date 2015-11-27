class CategoryNode < Struct.new(:name, :children)
  def insert(category_tree)
    subcategory = children.select { |child| child.name == category_tree.name }.first

    if subcategory
      subcategory.insert(category_tree.children.first)
    else
      children << category_tree
    end
  end
end

class TreeBuilder
  def build(ext_categories)
    all_node = CategoryNode.new('All', [])

    ext_categories.split("\n").each do |line|
      category_root = parse_categories(line)

      all_node.insert(category_root)
    end

    all_node
  end

  private

  def parse_categories(line)
    categories = line.split('>')
    build_subtree(categories)
  end

  def build_subtree(categories)
    root = CategoryNode.new(categories.first.strip)
    if categories.length > 1
      root.children = [build_subtree(categories[1..-1])]
    end

    root
  end

end
