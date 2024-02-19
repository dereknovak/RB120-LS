# Concepts

## What is Object Oriented Programming?

"Object Oriented Programming is a programming paradigm that was created to deal with the growing complexity of large software systems."

Object Oriented Programming is a programming paradigm that was formed as a response to the growing complexity of large software systems, taking concepts such as variables and methods and transforming them into nouns and verbs. This new approach segregated data storage and functionality in small chunks that come together to perform larger tasks, allowing for cleaner maintenance and clearer code.

### Benefits of using OOP:
1. Creating objects allows for better abstraction with their code.
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

Polymorphism is the ability for multiple data types to respond differently to a common interface (methods).
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

# Modules and their use cases

## Method lookup path

# self

## Reading OO code

## Fake operators and equality

## Working with collaborator objects

## Create a code spike

