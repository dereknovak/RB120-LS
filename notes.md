Code spikes:
- rough draft
  - first attempt at class structure
  - throw away attempt
  - What you think needs to go where in classes and behaviors
- Spikes are part of agile methodology
- Don't need to go into implementation details
  - establish the different kinds of relationships between classes/methods
  - where are methods placed, which classs?
- create instances of classes without throwing errors
- Given a prompt, create a series of classes/behaviors
  - Have appropriate accessors
    - don't have to worry about behaviors

Questions
- Please express 2 ways to express polymorphism

Duck Typing
- 

Collaborator Objects
- An object that is part of another object's state
- They are typically custom class objects
- There is 'intention' to make it a collaborator

Constants
- Looks lexically
- Looks up inheritance
- Looks at main scope

module Describable
  def describe_shape
    "I am a #{self.class} and have #{SIDES} sides."
  end
end

class Shape
  # SIDES = 9
  include Describable

  def self.sides
    self::SIDES
  end
  
  def sides
    # SIDES
    self.class::SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4
end

class Square < Quadrilateral; end

p Square.sides 
p Square.new.sides 
p Square.new.describe_shape 


# What is output and why? What does this demonstrate about constant scope? What does `self` refer to in each of the 3 methods above? 

# Constant Resolution Path
  # 1. Searches Lexically
  # 2. Searches the Inheritance Chain
  # 3. Checks the Top Scope   