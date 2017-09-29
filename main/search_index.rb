class SearchIndex
  def initialize(list)
    @list = []
    list.map { |record| insert(record) }
  end

  def find(num)
    @list.find { |item| item[:num] == num }
  end

  def insert(record)
    @list.push(record) unless find(record[:num])
    @list.sort! { |a, b| a[:num] <=> b[:num] }
  end

  def count
    @list.length
  end

  def find_range(range = [])
    return [] if @list.empty?

    lb_index = range[0] ? @list.find_index { |item| item[:num] >= range[0] } : 0
    ub_index = range[1] ? @list.find_index { |item| item[:num] > range[1] } - 1 : -1

    @list[lb_index..ub_index]
  end

  private

  def find_index(records, id, real_index_range)
    middle = records.length / 2
    middle_index = records.index(middle)
    id > middle[:num] ? find_index(records[0..middle_index], id, 0..middle_index) : find_index(records[middle_index..-1], id, middle_index..-1)
  end
end
