# Natalie Thompson

Add 1 method for the person class.
and 1 line of code in the initalize method.
Other than that don't change Person.

Output:
"My name is Roger and I am a Carpenter"

```ruby
class Person
  def initialize(name, job)
      @name = name
  end 
end

roger = Person.new("Roger", "Carpenter")
puts roger
```

My solution

```ruby
class Person
  def initialize(name, job)
      @name = name
      @job = job
  end

  def to_s
    "My name is #{@name} and I am a #{@job}"
  end
end
```

# Raul Romero 1

Expected output:
Hi, my name is Jo and I have blonde hair.
Hi, my name is Dylan and I have blonde hair.
```ruby
class Human 
    attr_reader :name

  def initialize(name="Dylan")
    @name = name
  end
end

puts Human.new("Jo").hair_colour("blonde")  
puts Human.new.hair_colour("")              
```

My solution

```ruby
class Human 
  attr_reader :name

  def initialize(name="Dylan")
    @name = name
  end

  def hair_colour(color)
    color = 'blonde' if color.empty?
    "Hi, my name is #{name} and I have #{color} hair."
  end
end

puts Human.new("Jo").hair_colour("blonde")
puts Human.new.hair_colour("")
```

# Oscar Cortes

Without adding any methods below, implement a solution that returns `true` for lines 24/25.

```ruby
class ClassA 
  attr_reader :field1, :field2
  
  def initialize(num)
    @field1 = "xyz"
    @field2 = num
  end
end

class ClassB 
  attr_reader :field1

  def initialize
    @field1 = "abc"
  end
end


obj1 = ClassA.new(50)
obj2 = ClassA.new(25)
obj3 = ClassB.new


p obj1 > obj2
p obj2 > obj3
```

My solution

```ruby
class ClassA 
  attr_reader :field1, :field2
  
  def initialize(num)
    @field1 = "xyz"
    @field2 = num
  end
end

class ClassB 
  attr_reader :field1

  def initialize
    @field1 = "abc"
  end
end


obj1 = ClassA.new(50)
obj2 = ClassA.new(25)
obj3 = ClassB.new


p obj1.field2 > obj2.field2
p obj2.field1 > obj3.field1
```

# Unknown

Implement code to allow the for the desired output.

```ruby
class BenjaminButton 
  
  def initialize
  end
  
  def get_older
  end
  
  def look_younger
  end
  
  def die
  end
end

benjamin = BenjaminButton.new
p benjamin.actual_age # => 0
p benjamin.appearance_age # => 100

benjamin.actual_age = 1
p benjamin.actual_age # => 1

benjamin.get_older
p benjamin.actual_age # => 2
p benjamin.appearance_age # => 99

benjamin.die
p benjamin.actual_age # => 100
p benjamin.appearance_age # => 0
```

My solution

```ruby
class BenjaminButton
  attr_accessor :actual_age, :appearance_age
  
  def initialize
    @actual_age = 0
    @appearance_age = 100
  end
  
  def get_older
    self.actual_age += 1
    look_younger
  end
  
  def look_younger
    self.appearance_age -=1
  end
  
  def die
    self.actual_age = 100
    self.appearance_age = 0
  end
end
```

# LS Man

```ruby
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

p superman.fly # => I am Superman, I am a Superhero, and I can fly!

LSMan.fight_crime 
# => I am LSMan!
# => I fight crime with my coding skills ability!
```
