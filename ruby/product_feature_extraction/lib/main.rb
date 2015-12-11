require 'csv'
require 'pry'

class FeatureExtractor

  attr_accessor :products

  COLOUR_EXTRACTION = /purple|black|blue/i

  SIZE_EXTRACTION = /(\d+)(?:(?:[ -]?(in|inch|cm|")))/i

  MEMORY_EXTRACTION = /\d+(?: ?)gb/i

  def initialize
    @products = []
    f = File.open('fixtures/products.csv')
    f.readline
    f.each_line do |line|
      @products << {title: line[0..-2]}
    end
  end

  def extract_colour
    extract_feature(:colour, COLOUR_EXTRACTION)
  end

  def extract_memory
    extract_feature(:memory, MEMORY_EXTRACTION)
  end

  def extract_size
    extract_feature(:size, SIZE_EXTRACTION) do |match|
      match[1].gsub!(/^"|in$/i, 'inch')
      match.join(' ')
    end
  end

  private

  def extract_feature(name, regex, &callback)
    @products.each do |product|
      matches = product[:title].scan(regex).compact
      matches.map! { |m| yield(m) } if block_given?
      product[name] = matches.uniq.map(&:downcase) unless matches.empty?
    end
  end
end