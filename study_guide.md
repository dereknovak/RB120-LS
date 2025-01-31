# RB120 Concepts

## Navigation

- [What is OOP?](#what-is-object-oriented-programming)
- [Benefits of OOP](#benefits-of-using-oop)
- [Class and Objects](#classes-and-objects)
- [Instance Variables](#instance-variable)
- [Class Variables](#class-variable)
- [Constants](#constants)
- [Constructor Method](#constructor-method)
- [Getter/Setter](#getter-and-setter-methods)
- [Instance Method vs Class Method](#instance-method-vs-class-method)
- [Module](#module)
- [Attributes](#attributes)
- [Encapsulation](#encapsulation)
- [Polymorphism](#polymorphism)
- [Collaborator Objects](#collaborator-objects)
- [Method Lookup Path](#method-lookup-path)
- [self](#self)
- [super](#super)
- [Class Inheritance vs Mixin](#class-inheritance-vs-mixin)
- [Equivalence](#equivalence)
- [Fake Operators](#fake-operators)

## What is Object Oriented Programming?

"Object Oriented Programming is a programming paradigm that was created to deal with the growing complexity of large software systems."

Object Oriented Programming is a programming paradigm that was formed as a response to the expanding complexity of large software systems, dividing data storage and functionality into small chunks that come together to perform larger tasks.

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

## Instance Variable

Instance variables are variables that are scoped at the *object level*, making them only available within the current instance of the class.

```ruby
class Musician
  def initialize(name, instrument, job)
    @name = name
    @instrument = instrument
    @job = job
  end
end

bob = Musician.new('Bob', 'trumpet', 'soloist')         
steve = Musician.new('Steve', 'violin', 'concertmaster')  

p bob    # => #<Musician:0x00000001030b74e0 @name="Bob", @instrument="trumpet", @job="soloist">
p steve  # => #<Musician:0x00000001030b7198 @name="Steve", @instrument="violin", @job="concertmaster">
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

Sheep.total  # => 0

sheep1 = Sheep.new
sheep2 = Sheep.new

Sheep.total  # => 2
```

## Constants

A constant is a variable that does not change throughout the code.

### Lexical Scope

"Lexical scope means that where the constant is defined in the source code determines where it is available."

Constants have lexical scope, which means that their value is only available within the structure where they're defined, unless explicitly referenced by the scope resolution operator. When searching for a constant, Ruby first looks lexically, then through inheritance, and concludes with the main scope.

```ruby
class Instrument
  KEY = 'C'

  def transpose
    puts "Transposing to the key of #{self.class::KEY}"
  end
end

class Clarinet < Instrument
  KEY = 'B-flat'
end

class FrenchHorn < Instrument
  KEY = 'F'
end

class Violin < Instrument; end
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

Interacting with the state of an object throughout Object Oriented Programming is accomplished primarily through the use of getter and setter methods. Ruby employs an easy process of defining these methods through the use of the `attr_*` method, creating getter methods with `attr_reader`, setter methods with `attr_writer`, and both simultaneously with `attr_accessor`,  passing each attribute in as a symbol argument.

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

## Instance method vs Class method

Instance methods can be called on any instantiated object within its respective class, while class methods are only called on the class itself and can be called without any objects instantiated. While an instance method has a standard `def...end` definition within the class structure, a class method *must* be prepended with `self.` (`self.my_method`).

```ruby
class Musician
  @@total_musicians = 0

  def initialize(name, instrument)
    @name = name
    @instrument = instrument
    @@total_musicians += 1
  end

  def self.total
    @@total_musicians
  end

  def play
    puts "#{@name} is playing their #{@instrument}."
  end
end

derek = Musician.new('Derek', 'clarinet')
bob = Musician.new('Bob', 'saxophone')

derek.play  # Derek is playing their clarinet.
Musician.total  # => 2
```
## Module

"A module is a collection of behaviors that is usable in other classes via mixins."

A module contains a collection of behaviors that can used by other classes through mixins. They can also be used to group similar classes together via *namespacing*, preventing collisions with other classes that share the same name.

The 3 purposes of modules:
1. Interface inheritance
2. Namespacing
3. Container modules

### Class vs Module

Similarities

1. Both are structures and can be thought of as containers.
2. Both have the ability to inherit, though this is more common to see in classes.
3. Both use the same PascalCase syntax.

Notable differences

1. Classes represent the attributes and behaviors of an object, while modules are simply just act as containers.
2. An object can be instantiated from a class, thereby encapsulating state. Modules cannot.
3. A class can only inherit from one parent class, but can inherit an limitless number of modules.

### Mixin

A mixin refers to a module that has been "mixed-in" to a class via the `include` keyword, allowing its behaviors to be used within the class.

```ruby
module Runable
  def run
    puts "I'm running!"
  end
end

class Person
  include Runable
end

Person.new.run  # => "I'm running!"
```

### Namespacing

"Namespacing means organizing similar classes under a module."

Namespacing is used to organize similar classes within a module, preventing collisions with other classes that share the same name. When referencing a namespaced class, the namespace resolution operator must be used to properly locate the class structure.

```ruby
module Toys
  class Truck; end
  class Car; end
end

Toys::Truck.new

module Vehicles
  class Truck; end
  class Car; end
end

Vehicles::Truck.new
```

### Container Methods

"This involves using modules to house other methods. This is very useful for methods that seem out of place within your code."

Container methods, also called *module methods*, are used to house methods that do not seem to organizationly fit anywhere in the codebase. Rather than crowd a class structure with extraneous methods, these methods can be extracted to their own module for better codebase organization.

```ruby
module ProgramFunctionality
  def prompt(messsage)
    puts "=> #{message}"
  end

  def continue_program
    puts "Press [ENTER] to continue"
    gets
  end
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

"Encapsulation lets us hide the internal representation of an object from the outside and only expose the methods and properties that users of the object need."

Encapsulation allows us to hide the state of an object from outside its respective class, exposing only the attributes and behaviors required by the users. In Object Oriented Programming, this is primarily achieved through Method Access Control, which allows or restricts access to these properties by the implementation of public, protected, or private methods.

### Method Access Control

"Access Control is a concept that exists in a number of programming languages, including Ruby. It is generally implemented through the use of access modifiers. The purpose of access modifiers is to allow or restrict access to a particular thing."

Method Access Control allows or restricts access to specific properties by the implementation of *access modifiers*; in Ruby, these modifiers include the `public`, `protected`, and `private` keywords.

By default, all defined instance methods -- excluding `initialize` -- are considered public methods.

### Private methods

Private methods are only accessible within the current class instance, preventing invocation to any objects, including `self`, outside of the class definition.

```ruby
class Human
 def initialize(name, ssn)
   @name = name
   @ssn = ssn
 end
 
 def encripted_ssn
   "XXX-XX-#{ssn.to_s[5, 4]}"
 end

 private

 attr_reader :ssn
end

charlie = Human.new('Charlie', 123456789)
charlie.encripted_ssn  # => "XXX-XX-6789"
charlie.ssn  # => NoMethodError 'private method'
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

### Example

```ruby
class Human
 def initialize(name, age, ssn)
   @name = name
   @age = age
   @ssn = ssn
 end

 def older_than?(other)
  age > other.age
 end
 
 def encripted_ssn
   "XXX-XX-#{ssn.to_s[5, 4]}"
 end

 protected

 attr_reader :age

 private

 attr_reader :ssn
end

charlie = Human.new('Charlie', 30, 123456789)
stephen = Human.new('Stephen', 18, 987654321)
```

## Polymorphism

"Polymorphism is the ability for different types of data to respond to a common interface."

Polymorphism is the ability for multiple data types to respond differently to a common interface (methods). Two forms of Polymorphism exist within Object Oriented Programming: Polymorphism via inheritance and Duck Typing.

### Polymorphism via inheritance

Polymorphism via inheritance can be achieved through two different approaches, *class* and *interface* inheritance.

Class inheritance use a behavior from a shared parent-class, allowing each subclass to respond to it. Individual subclasses may have unique implemetations of the behavior, *overriding* its execution.

```ruby
class Human
  def sleep
    puts "I'm sleeping!"
  end
end

class Adult < Human; end
class Child < Human; end
class Baby < Human; end

[Adult.new, Child.new, Baby.new].each(&:sleep)

# I'm sleeping!
# I'm sleeping!
# I'm sleeping!
```

Interface inheritance uses mixins to share a behavior with various *related* classes, allowing each object from those classes the ability to respond to the behavior. It is best utilized when multiple, but not all, subclasses from a common parent class share a behavior; rather than defining the behavior in the parent class, the behavior can be extracted to a module and added as a mixin to the relevant subclasses.

```ruby
module Runable
  def run
    puts "I'm running!"
  end
end

class Human; end

class Adult < Human
  include Runable
end

class Child < Human
  include Runable
end

class Baby < Human; end

[Adult.new, Child.new, Baby.new].each(&:run)

# I'm running!
# I'm running!
# undefined method `run' for #<Baby:0x000000010f832fb0> (NoMethodError)
```

*** When deciding on whether to use class inheritance or a mixin, first determine what kind of relationship it shares with the class. If it employs a 'is a' relationship, class inheritance should be used, while 'has a' relationships should use a mixin.

### Duck typing

"Duck typing occurs when objects of different *unrelated* types both respond to the same method name."

Duck typing, stemmed from the phrase "if it walks and quacks like a duck, it must be a duck," occurs when multiple *unrelated* classes share a common behavior, allowing objects from either class the ability to respond to it. While the objects should be unrelated, their behaviors should perform a similar action.

```ruby
class CashRegister
  def refill
    @money = 300
  end
end

class SodaMachine
  def refill
    @pepsi = 100
    @sprite = 100
  end
end

# Morning routine
[CashRegister.new, SodaMachine.new].each(&:refill)
```

## Collaborator Objects

"Objects that are stored as state within another object are also called "collaborator objects". We call such objects collaborators because they work in conjunction (or in collaboration) with the class they are associated with."

"Collaborator objects allow you to chop up and modularize the problem domain into cohesive pieces"

Collaborator objects are objects that are stored as state within another object. While these can include any kind of object, including strings, numbers, arrays, and so on, they typically reference *custom objects*, as a collaborative relationship is established between the two classes. This allows the programmer to further divide their codebase into smaller, more cohesive pieces.

```ruby
class Musician
  def initialize(name, instrument)
    @name = name
    @instrument = instrument
  end
end

class Instrument
  def initialize(type)
    @type = type
  end
end

clarinet = Instrument.new('clarinet')
derek = Musician.new('Derek', clarinet)
```

## self

In Ruby, `self` represents the *calling object* and is used to disambiguate the intention of a method call. When used within an instance method, `self` represents the current instance of the class; outside of it, including within a class method defintion, it represents the structure where it is invoked.

```ruby
module Drivable
  def drive
    puts "Driving my #{self.class}."
  end
end

class Vehicle
  include Drivable

  attr_accessor :color

  def paint(color)
    self.color = color
  end

  def self.fuel_economy(miles, gallons)
    "#{miles / gallons} mpg"
  end
end

class Car < Vehicle; end
class Truck < Vehicle; end

mazda = Car.new
ford = Truck.new

mazda.drive  # Driving my Car.
ford.drive  # Driving my Truck.

mazda.paint('orange')
mazda.color  # => "orange"

Car.fuel_economy(400, 12)  # => "33 mpg"
```

## Method Lookup Path

"The Method Lookup Path is the order in which classes are inspected when you call a method."

The Method Lookup Path is the order in which Ruby searches for a method definition through the chain of inheritance when it is invoked. Ruby will begin in the current class, check the mixins from last to first included, then move to its superclass, executing the first definition it finds. We can view the current method lookup path by calling the `ancestors` class method on the object's class.

## super

"Ruby provides us with the super keyword to call methods earlier in the method lookup path. When you call super from within a method, it searches the method lookup path for a method with the same name, then invokes it."

The `super` keyword allows a program to invoke the closest method in the class's chain of inheritance that shares the name of the current method invocation, allowing its functionality to be executed at the location of the keyword. This allows for less repetitive code, as more consistently used functionality can be housed in a parent class's method, while the subclass has a more specific implemenation.

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

"
- You can only subclass (class inheritance) from one class. You can mix in as many modules (interface inheritance) as you'd like.
- If there's an "is-a" relationship, class inheritance is usually the correct choice. If there's a "has-a" relationship, interface inheritance is generally a better choice. For example, a dog "is an" animal and it "has an" ability to swim.
- You cannot instantiate modules. In other words, objects cannot be created from modules.
"

When determining whether to implement class inheritance versus using a mixin, there are three things to keep in mind:

1. Objects cannot be instantiated from modules.
2. A class can only inherit from one parent class; alternatively, there is no (reasonable) limit to how many modules can be mixed into a class.
3. If the two structures in question share a "is-a" relationship, class inheritance is more suitable. If they share a "has-a" relationship, using a mixin is more appropriate.

```ruby
module Swimable; end

class Human; end

class Athlete < Human  # An athlete "is-a" human
  include Swimable     # An athlete "has-a" ability to swim
end
```
## Equivalence

`==` vs `equal?` vs `eql?` vs `===`

The `==` operator compares the value of its operands, returning `true` if they are equal and `false` otherwise.

The `===` (case) operator compares the its operands, returning `true` if its left operand is within the range of its right operand and `false` otherwise.

The `equal?` method compares the object IDs of its operands, returning `true` if they are the same object and `false` otherwise.

The `eql?` method compares its two operands, returning `true` if both the class and value are the same and `false` otherwise.

```ruby
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

jack = Person.new("Jonathon")
john = Person.new("Jonathon")

jack.name == john.name       # => true
jack.name.equal?(john.name)  # => false
jack.name.eql?(john.name)    # => true
```

## Fake operators

"It only looks like an operator because Ruby gives us special syntactical sugar when invoking that method."

Many of the "operators" that are used throughout the Ruby language are methods calls *disguised* as operators through the use of *syntactical sugar*, allowing the code to be more readable and predictable. We call these **fake operators**.

While many of the pre-existing Ruby classes and modules have their own defintions to these methods, a custom class does not by default; therefore, if we wish to implement its functionality into our program, we have to define its operation.

```ruby
class Person
  def initialize(name, age)
    @name = name
    @age = age
  end

  def >(other)
    age > other.age
  end

  protected

  attr_reader :age
end

sally = Person.new('Sally', 32)
barbara = Person.new('Barbara', 55)

sally > barbara  # => false
```

Actual Ruby Operators:
- All assignment operators, *except* `[]=`
- Logical operators
- Scope resolution operator
- Method resolution operator

## Accidental Method Override

Don't use this example, but build from it
```ruby
class Child
  def say_hi
    p "Hi from Child."
  end

  def send
    p "send from Child..."
  end
end

lad = Child.new
lad.send :say_hi
```