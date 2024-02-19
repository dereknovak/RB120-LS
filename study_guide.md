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

## Module

"A module is a collection of behaviors that is usable in other classes via mixins."


A module contains a collection of behaviors that can used by other classes through mixins. They can also be used to group similar methods together via *namespacing*, allowing more organized code and preventing collisions through similarly named classes.

### Mixin

A mixin refers to a module that has been "mixed-in" to a class via the `include` keyword, allowing its behaviors to be used within the class.

### Namespacing

"Namespacing means organizing similar classes under a module."

```ruby

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


-------------------------------

## Classes and Objects

## Use attr_* to create setter and getter methods

## How to call setters and getters

## Instance variables

## Class variables

## Constants

## Instance methods vs Class methods

## Method Access Control

## Referencing and setting instance variables vs. using getters and setters

## Class inheritance

## Encapsulation

## Polymorphism

## Modules and their use cases

## Method lookup path

## self

## Reading OO code

## Fake operators and equality

## Working with collaborator objects

## Create a code spike

