# frozen_string_literal: true

class Greeting
  @@people = []

  def initialize(name)
    @@people << name
    puts "Hello #{name}!"
  end

  def self.clear
    @@people = []
  end

  def self.people
    @@people
  end
end
