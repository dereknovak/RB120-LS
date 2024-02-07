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

-------------------------

# SPOT SESSION with ESTHER

Encapsulation
- The data is encap in the object made in the class
- Restricts access to the state of an object
- OO gives us a means to encasulate data
  - level of abstraction
- MAC is a form of encapsulation
  - Only for instance methods

POLYMORPHISM
- Thru inheritance
  - Class inheritance
  - Interface inheritance
- Duck typing
- Needs to be done with intention

- Constant resolution operator
  - searches location specified
    - ONLY the specific container
  - searches inheritance chain of the specified container
  - Does NOT search the top level ***

Constant Problem to play around with

```ruby
WHEELS = 42

module Drivable
  # WHEELS = 21

  class Car
    # WHEELS = 4
    # include Drivable

    def how_many
      WHEELS
    end
  end
  
  class Motorcycle
    WHEELS = 2

    def how_many
      Drivable::Car::WHEELS
    end
  end
end



mazda = Drivable::Car.new
honda = Drivable::Motorcycle.new

puts mazda.how_many #=> 21
# puts Drivable::Car.ancestors
puts honda.how_many
```