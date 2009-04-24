#!/usr/bin/env ruby

class Effect
  @@effects = Hash.new {|hash, key| hash[key] = Effect.new(key)}
  attr_accessor :name, :results
  
  def initialize(name)
    self.name = name
    self.results = []
  end
  
  def self.add(name, result)
    @@effects[name].add(result)
  end
  
  def self.results
    @@effects.values.sort_by {|e| e.avarage}.map {|e| e.to_s}
  end

  def add(result)
    results << result.to_f
  end
  
  def avarage
    total / results.length
  end
  
  def max
    results.max
  end
  
  def min
    results.min
  end
  
  def total
    results.inject {|sum, n| sum + n }
  end
  
  def to_s
    "avarage: %.4f   max: %.4f   min: %.4f   total: %.4f) #{name}" % [avarage, max, min, total]
  end
end

file = File.open(ARGV[0], "r") if ARGV[0]
file ||= STDIN

lines = file.readlines

lines.each do |line|
  if line =~ /^Rendering ([^(]+) \(([^)]+)\)$/
    Effect.add($1,$2)
  end
end

puts Effect.results.reverse.join("\n")
