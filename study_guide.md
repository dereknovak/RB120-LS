# Concepts

## What is Object Oriented Programming?

"Object Oriented Programming is a programming paradigm that was created to deal with the growing complexity of large software systems."

Object Oriented Programming is a programming paradigm that was formed as a response to the growing complexity of large software systems, dividing data storage and functionality into small chunks that come together to perform larger tasks.

### Benefits of using OOP:
1. Creating objects allows for better code abstraction
2. Objects and methods are represented with nouns and verbs
3. Functionality of the code is much easier to manipulate, preventing namespacing issues.
4. Duplication is avoided through the use of inheritance.
5. Functionality is organized into smaller parts, allowing for better reusability and maintenance.

## Classes and objects

"Ruby defines the attributes and behaviors of its objects in **classess**. You can think of classes as basic outlines of what an object should be made of and what is should be able to do."

Classes represent the attributes and behaviors that exist within an object. A class is defined using the `class` keyword and incorporates a PascalCase naming convention. Each class can stand alone or inherit from a single parent-class, allowing its functionality to be inherited. Objects are *instantiated* from their respective class, allowing the storage of *state* through their attriubutes and the ability to interact with the codebase through the defined instance methods, or *behaviors*, existing within the class.

```ruby
class Musician
  # Attributes and Behaviors...
end

michael = Musician.new  # <= Object is instantiated
```

## Class Variable

Class variables are variables that scoped at the *class level*, making them available to all instances of the class.

AVOID:
When working with inheritance, it's best to avoid the usage of class variables, as defining new classes or instantiating objects may inadvertenly change the value of the variable.

```ruby
class Sheep
  @@total_sheep = 0

  def initialize
    @@total_sheep += 1
  end

  def self.total
    @@total_sheep
  end
end

puts Sheep.total  # 0

sheep1 = Sheep.new
sheep2 = Sheep.new

puts Sheep.total  # 2
```

## Constants

A constant is a variable that does not change throughout the code.

### Lexical Scope

"Lexical scope means that where the constant is defined in the source code determines where it is available."

Constants have lexical scope, which means that their value is only available within the structure where they're defined, unless explicitly referenced by the scope resolution operator. When searching for a constant, Ruby first looks lexically, then through inheritance, and concludes with the main scope.

```ruby
module Orchestra
  KEY = 'C'

  class Musician
    include Orchestra

    def transpose
      puts "Transposing to the key of #{self.class::KEY}"
    end
  end

  class Violinist < Musician; end

  class Clarinetist < Musician
    KEY = 'B-flat'
  end
  
  class Hornist < Musician
    KEY = 'F'
  end
end

victor = Orchestra::Violinist.new
claire = Orchestra::Clarinetist.new
henry = Orchestra::Hornist.new

[victor, claire, henry].each(&:transpose)
```

## Constructor method

"A constructor method is a special method that builds the object when a new object is instantiated."

The `initialize` instance method acts as the class's *constructor method*, which is a special method that builds an object upon instantiation.

```ruby
class Pizza
  attr_reader :size, :toppings

  def initialize(size, *toppings)
    @size = size
    @toppings = toppings
  end
end

dominos = Pizza.new('large', 'sausage', 'black olives', 'mushrooms')
dominos.toppings  # => ['sausage', 'black olives', 'mushrooms']
```

## Getter and Setter methods

Interacting with the state of an object throughout Object Oriented Programming is accomplished primarily through the use of getter and setter methods. Ruby employs an easy method of defining these methods through the use of the `attr_*` method, creating getter methods with `attr_reader`, setter methods with `attr_writer`, and both simultaneously with `attr_accessor`,  passing each attribute in as a symbol argument.

```ruby
class Person
  attr_accessor :age
  attr_reader :name
  attr_writer :gender

  def initialize(name, gender, age)
    @name = name
    @gender = gender
    @age = age
  end
end

jimmy = Person.new('Jimmy', 'Male', 32)
jimmy.age  # => 32
jimmy.age += 1  # => 33

jimmy.name  # => 'Jimmy'
jimmy.name = 'Bob'  # => NoMethodError

jimmy.gender = 'Non-binary'
jimmy.gender  # => NoMethodError
```

## Module

"A module is a collection of behaviors that is usable in other classes via mixins."


A module contains a collection of behaviors that can used by other classes through mixins. They can also be used to group similar methods together via *namespacing*, allowing more organized code and preventing collisions through similarly named classes.

### Mixin

A mixin refers to a module that has been "mixed-in" to a class via the `include` keyword, allowing its behaviors to be used within the class.

### Namespacing

"Namespacing means organizing similar classes under a module."

```ruby
module Orchestra
  class Violinist; end
  class Clarinetist; end
  class Trumpeter; end
  class Percussionist; end
end
```
## Attributes

"We can think of attributes as the different charactersistic that make up an object."

Attributes represent the various characteristics that make up an object, with the collection of all attribute values determining its *state*. They are defined using the instance variables of a class and are generally interacted with using getter or setter instance methods. All instances of a class will contain the same attributes, but may have a variety of states that represent them.

```ruby
class Musician
  attr_reader :name, :instrument  # <= These are the attributes

  def initialize(name, instrument)
    @name = name
    @instrument = instrument
  end
end
```

## Encapsulation

"Encapsulation is hiding pieces of functionality and making it unavailable to the rest of the code base."

Encapsulation occurs by hiding pieces of functionality, making it unavailable to the rest of the codebase. In Object Oriented Programming, this is primarily achieved through Method Access Control, which allows or restricts this functionality by implementation of public, protected, or private attributes or behaviors.

### Method Access Control

"Access Control is a concept that exists in a number of programming languages, including Ruby. It is generally implemented through the use of access modifiers. The purpose of access modifiers is to allow or restrict access to a particular thing."

### Private methods

Private methods are only accessible within the current class instance, preventing invocation to any objects, including `self`, outside of the class definition.

```ruby
class Human
 def initialize(name, ssn)
   @name = name
   @ssn = ssn
 end
 
 def encripted_ssn
   "XXX-XX-#{ssn[7, 4]}"
 end

 private

 attr_reader :ssn
end

charlie = Human.new('Charlie', '123-45-6789')
puts charlie.encripted_ssn  # XXX-XX-6789
```

### Protected methods

Protected methods are only accessible within the current class instance, preventing invocation to any objects, including `self`, outside of the class definition; however, the method can be called on a different class instance *within* the class definition.

```ruby
class Clarinet
 def initialize(price)
   @price = price
 end

 def nicer_than?(other)
   price > other.price
 end

 protected

 attr_reader :price
end

buffet_tosca = Clarinet.new(8000)
selmer_privilage = Clarinet.new(5000)

puts buffet_tosca.nicer_than?(selmer_privilege)  # true
```

## Polymorphism

"Polymorphism is the ability for different types of data to respond to a common interface."

Polymorphism is the ability for multiple data types to respond differently to a common interface (methods). Two forms of Polymorphism exist within Object Oriented Programming: Polymorphism via inheritance and Duck Typing.

### Polymorphism via inheritance

Polymorphism via inheritance can be achieved through two different approaches, *class* and *interface* inheritance.

Class inheritance use a behavior from a shared parent-class, allowing each subclass to respond to it. Individual subclasses may have unique implemetation of the behavior, *overriding* its execution.

```ruby
class Musician
  def play
    "Playing my "
  end
end

class Clarinetist < Musician
  def play
    puts super + 'clarinet'
  end
end

class Violinist < Musician
  def play
    puts super + 'violin'
  end
end

claire = Clarinetist.new
victor = Violinist.new

[claire, victor].each(&:play)
```

Interface inheritance uses mixins to share a behavior with various classes, allowing each object from those classes the ability to respond to the behavior.

```ruby
module Runable
  def run
    puts "I'm running!"
  end
end

class Athlete
  include Runable
end

class Dog
  include Runable
end

aaron = Athlete.new
max = Dog.new

[aaron, max].each(&:run)
```

*** When deciding on whether to use class inheritance or a mixin, first determine what kind of relationship it shares with the class. If it employs a 'is a' relationship, class inheritance should be used, while 'has a' relationships should use a mixin.

### Duck typing

"Duck typing occurs when objects of different *unrelated* types both respond to the same method name."

Duck typing, stemmed from the phrase "if it walks and talks like a duck, it must be a duck," occurs when multiple classes share a common behavior, allowing objects from either class the ability to respond to it. While the objects should be unrelated, their behaviors should perform a similar action.

```ruby
class Duck
 def quack
   puts "Quack, quack, quack!"
 end
end

class Impressionist
 def quack
   puts "Quack, quack, quack!"
 end
end

donald = Duck.new
tom = Impressionist.new

[donald, tom].each(&:quack)
```

## Method Lookup Path

"The Method Lookup Path is the order in which classes are inspected when you call a method."

The Method Lookup Path is the order in which Ruby searches for a method definition through inheritance when it the method is invoked. Ruby will start in the current class, check the mixins from last to first defined, then move to its superclass, executing the first definition it finds. We can view the current method lookup path by calling the `ancestors` class method on the object's class.

## super

"Ruby provides us with the super keyword to call methods earlier in the method lookup path. When you call super from within a method, it searches the method lookup path for a method with the same name, then invokes it."

```ruby
class Occupation
  def work
    "I'm making money by "
  end
end

class Musician < Occupation
  def work
    super + "playing my "
  end
end

class Clarinetist < Musician
  def work
    puts super + "clarinet!"
  end
end

claire = Clarinetist.new
claire.work
```

## Class inheritance vs mixin

"If there's an "is-a" relationship, class inheritance is usually the correct choice. If there's a "has-a" relationship, interface inheritance is generally a better choice."

## Equivalence

`==` vs `equal?` vs `eql?` vs `===`

The `==` operator compares the value of its operands, returning `true` if they are equal and `false` otherwise.

The `===` (case) operator compares the its operands, returning `true` if its left operand is within the range of its right operand and `false` otherwise.

The `equal?` method compares the object IDs of its operands, returning `true` if they are the same object and `false` otherwise.

The `eql?` method compares its two operands, returning `true` if both the class and value are the same and `false` otherwise.

## Fake operators

"It only looks like an operator because Ruby gives us special syntactical sugar when invoking that method."

Many of the "operators" that are used throughout the Ruby language are methods disguised as operators through the use of *syntactical sugar*, allowing the code to be more readable and predictable.

Actual Ruby Operators:
- All assignment operators, *except* `[]=`
- Logical operators
- Scope resolution operator
- Method resolution operator

-------------------------------


## Instance variables


## Instance methods vs Class methods


## Modules and their use cases


## self

## Reading OO code


## Working with collaborator objects

## Create a code spike

