```ruby
=begin

RB129 SPOT Session

Introductions
- What is your name?
- Where are you in the course?
- What would you like to cover today?

DISCLAIMER
- I am not a TA, so I can only speak from my own experience preparing/taking the exams
- I cannot disclose specific assessment questions

=end
```

## LS Man

```ruby
# Lines 40 and 42 should output their respective strings. You can only add code within the module/classes. You cannot remove any existing code.

module Flightable
  def fly
    puts "I am #{}, I am a #{}, and I can fly!"
  end
end

class Superhero
  include Flightable

  attr_accessor :ability
  
  def self.fight_crime
    puts "I am #{}"
    # cannot use `puts` here
  end
  
  def initialize(name)
    @name = name
  end
  
  def announce_ability
    puts "I fight crime with my #{ability} ability!"
  end
end

class LSMan < Superhero; end

class Ability
  attr_reader :description

  def initialize(description)
    @description = description
  end
end

superman = Superhero.new('Superman')

superman.fly # => I am Superman, I am a Superhero, and I can fly!

LSMan.fight_crime 
# => I am LSMan!
# => I fight crime with my coding skills ability!
```