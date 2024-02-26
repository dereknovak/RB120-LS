# 1

What is output and why? What does this demonstrate about instance variables that differentiates them from local variables?

```ruby
class Person
  attr_reader :name
  
  def set_name
    @name = 'Bob'
  end
end

bob = Person.new
p bob.name
```
This example will output `nil`. Because the `:name` getter method is defined using the `attr_reader` keyword, the instance variable `@name` is assigned to `nil` until instructed otherwise. While `@name` is assigned to the string object `'Bob'` within the `set_name` instance method, this method is never invoked, and therefore continues to reference `nil`, which is what is seen output after calling `name` on the object `bob`.

This problem showcases a couple of different aspects between local variables and instance variables. First, instance variables are scoped at the *object level*, allowing them to be accessible throughout the entire instance of a class, while local variables are only available within the scope in which it is defined. Secondly, when defining a getter method, an instance variable automatically takes on the value of `nil`, even if nothing has been explicitly assigned to it, while local variables *must always* be explicitly defined in order to be accessible.

# 2

What is output and why? What does this demonstrate about instance variables?

```ruby
module Swimmable
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swimmable

  def swim
    "swimming!" if @can_swim
  end
end

teddy = Dog.new
p teddy.swim 
```
This example will output `nil`. Although the `enable_swimming` instance method is included in the `Dog` class via the `Swimmable` mixin, the method is never invoked, and therefore `@can_swim` is never assigned to `true` and remains `nil`, preventing `"swimming!"` from being output. In fact, because the method is never executed, `can_swim` is not even considered an attribute of the `teddy` object.

This demonstrates how instance variables automatically take on the value of `nil` even if not explicitly defined. Had this been a local variable, a `NameError` exception would have been thrown.

# 3

What is output and why? What does this demonstrate about constant scope? What does `self` refer to in each of the 3 methods above? 

```ruby
module Describable
  def describe_shape
    "I am a #{self.class} and have #{SIDES} sides."
  end
end

class Shape
  include Describable

  def self.sides
    self::SIDES
  end
  
  def sides
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
```
Line 25 will output `4`. Because the `sides` method is being called directly on the `Square` class, it is using the `self.sides` class method. Within this method, the `SIDES` constant is being referenced within the calling class, indicated by the `::` constant resolution operator with `self`, which directs Ruby to look within the `Square` class for the value. Because it is unable to locate a value there, it then follows the inheritance chain of the `Square` class, to which is finds `4` referenced in the `Quadrilateral` class, returning then outputting it by invocation of the `p` method.

Line 26 works in a similar fashion, but instead called the `sides` instance method on a new instance of the `Square` class. Within the method, the `class` method is called on `self`, which represents the calling object, returning `Square`, as the caller is an instance of the `Square` class. Like before, the constant resolution operator instructs Ruby to look within that class, then through the chain of inheritance, returning and outputting `4` due to the assignment within `Quadrilateral`.

Line 27 acts differently than the previous 2 lines, accessing the mixed-in `describe_shape` instance method, which returns `"I am a #{self.class} and have #{SIDES} sides."`. First off, `self` again references the calling object, which is the current instance of the `Square` class. For `SIDES`, Ruby looks lexically within the `Swimmable` module and is unable to find a value. Then, it follows the inheritance chain of `Swimmable`, again unable to find a reference. Lastly, it checks the main scope, and still cannot locate a value, so it throws a `NameError` exception, due to the inability to find a value for `SIDES`.

# 4

What is output? Is this what we would expect when using `AnimalClass#+`? If not, how could we adjust the implementation of `AnimalClass#+` to be more in line with what we'd expect the method to return?

```ruby
class AnimalClass
  attr_accessor :name, :animals
  
  def initialize(name)
    @name = name
    @animals = []
  end
  
  def <<(animal)
    animals << animal
  end
  
  def +(other_class)
    animals + other_class.animals
  end
end

class Animal
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
end

mammals = AnimalClass.new('Mammals')
mammals << Animal.new('Human')
mammals << Animal.new('Dog')
mammals << Animal.new('Cat')

birds = AnimalClass.new('Birds')
birds << Animal.new('Eagle')
birds << Animal.new('Blue Jay')
birds << Animal.new('Penguin')

some_animal_classes = mammals + birds

p some_animal_classes 
```
This example outputs an array containing all `Animal` class objects from both `mammals` and `birds`, in their object ID format. It's not explicit what may have been intended to be output, but the logic seems to line up, considering the `AnimalClass#+` instance method returns the concatenation of the `animals` states from both objects. If a clearer representation of the animals is intended, then the `name` should be called on each `Animal` object before the arrays are contenated together, returning the array `['Human', 'Dog', 'Cat', 'Eagle', 'Blue Jay', 'Penguin']`.

# 5

We expect the code above to output `”Spartacus weighs 45 lbs and is 24 inches tall.”` Why does our `change_info` method not work as expected?

```ruby
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def change_info(n, h, w)
    name = n
    height = h
    weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end


sparky = GoodDog.new('Spartacus', '12 inches', '10 lbs') 
sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info 
# => Spartacus weighs 10 lbs and is 12 inches tall.
```
Within the `change_info` instance method, *local variables* `name`, `height`, and `weight` are initialized to reference `n`, `h`, and `w`, respectively. Although we have a setter method defined for each attribute, Ruby is confused on whether or not a setter method is being called or a local variable is being assigned, so it assumes a local variable. Because of this, none of the states are changed, and the incorrect output is provided.

To explicitly indicate a setter method within an instance method, it must be prepended by `self.`, such as `self.name = n`. This cannot be confused with a local variable, so Ruby performs the appropriate action. You can also use `@name = n`, however the former is the preferred approach.

# 6
In the code above, we hope to output `'BOB'` on `line 16`. Instead, we raise an error. Why? How could we adjust this code to output `'BOB'`?
```ruby
class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def change_name
    name = name.upcase
  end
end

bob = Person.new('Bob')
p bob.name 
bob.change_name
p bob.name
```
The `NoMethodError` complaint is due to the assignment of *local variable* `name` to `nil` on line 9. Although we have a `name` setter method defined via `attr_accessor`, Ruby is confused on whether the setter method is being called or a local variable is being assigned, and chooses the local variable. When assigning a local variable, it references the temporary value of `nil` until the right operand of the assignment is evaluated. Because the `upcase` method is instantly called on the local variable `name`, which is `nil`, it throws the exception.

To specify a setter method within a class instance method, it must be prepended with `self.`, so to create no confusion of a local variable. Changing line 9 to `self.name = name.upcase` will reassign `@name` to calling `upcase` on its current value of `'Bob'`, which will now be `'BOB'`.

# 7

What does the code above output, and why? What does this demonstrate about class variables, and why we should avoid using class variables when working with inheritance?

```ruby
class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

p Vehicle.wheels                             

class Motorcycle < Vehicle
  @@wheels = 2
end

p Motorcycle.wheels                           
p Vehicle.wheels                              

class Car < Vehicle; end

p Vehicle.wheels
p Motorcycle.wheels                           
p Car.wheels 
```
Line 9 will output `4`. Because `wheels` is being called on the `Vehicle` class itself, its considered a class method and therefore references the `self.wheels` method within `Vehicle`. This method simply returns the `@@wheels` class variable, which is currently set to `4` from line 2.

Line 15 will output `2`. Because `Motorcycle` inherits from `Vehicle`, its methods become available within the class. Within `Motorcycle`, `@@wheels` is *reassigned* (more on this later) to `2`; therefore, when `wheels` is called on `Motorcycle`, that is what is output.

Line 16 will output `2`. Because `@@wheels` was reassigned on line 12, this change is seen even when calling it on the `Vechicle` class. Class variables are accessible throughout *all instances* of the class; because `Motorcycle` inherits from `Vehicle`, their class variables are shared.

Line 20 will output `2` for the same reason listed above. Although a new `Car` class is defined and inherits from `Vehicle`, it does not reassign the value of `@@wheels`, and therefore it remains the same.

Line 21 will, again, output `2` for the same reason as above. Nothing has been reassigned, and therefore continues to reference `2`.

Line 22 throws a curveball, calling `wheels` on the `Car` class, instead. Although `Car` does *not* inherit from `Motorcycle`, the reassignment is still seen and `2` is again output. Unlike methods, which are only executed when invoked, anything within the scope of a class is evaluated as Ruby moves line-by-line throughout the code. That means that, even without calling `wheels` on any of the classes, `@@wheels` is still initialized on line 2 and reassigned on line 12. Therefore, when calling `wheels` on any object that can access `@@wheels` established within the `Vehicle` class, they will see the value of its last reassignment.

This example demonstrates why it is important to avoid class variables when dealing with inheritance, as the value can change and create inconsistencies within your program. A better approach here would be to use a constant, allowing each vehicle to have its own value for `WHEELS` which can be either inherited from `Vehicle` or overridden to be its own value.

# 8

What is output and why? What does this demonstrate about `super`?

```ruby
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

bruno = GoodDog.new("brown")       
p bruno
```
Line 17 will output the `bruno` object ID, which will contain its individual ID and display both its `@name` and `@color` state as `'brown'`.

When instantiated the `bruno` object on line 16, the `initialize` constructor method receives `"brown"` as an argument and binds it to its parameter `color`. Within the method, the `super` keyword is employed, which invokes the method of the same name from its superclass. Because `super` takes no arguments, it automatically passes in `color` as an argument, binding its value `"brown"` to parameter `name`. This value is then assigned to `@name` within `Animal#initialize`, then `@color` within `GoodDog#initialize` afterwards. Because `GoodDog` inherits from `Animal`, both `@name` and `@color` attributes are present, and are seen when outputting the object.

# 9

What is output and why? What does this demonstrate about `super`? 

```ruby
class Animal
  def initialize
  end
end

class Bear < Animal
  def initialize(color)
    super
    @color = color
  end
end

bear = Bear.new("black")        
```
This example will throw an `ArgumentError` exception. Because the `super` within the `Bear#initialize` constructor method does not specify any arguments, it automatically passes all parameters from the current method to the superclass's method. Unfortunately, `Animal#initialize` does not contain any parameters, yet it is receiving one argument, so Ruby complains.

In order to circumvent this syntax quirk, you can call `super()`, which explicitly indicates that no arguments will be passed to the superclass method, allowing the code to run smoothly.

# 10

What is the method lookup path used when invoking `#walk` on `good_dog`?

```ruby
module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

module Danceable
  def dance
    "I'm dancing."
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end

module GoodAnimals
  include Climbable

  class GoodDog < Animal
    include Swimmable
    include Danceable
  end
  
  class GoodCat < Animal; end
end

good_dog = GoodAnimals::GoodDog.new
p good_dog.walk
```
The method lookup path will be as follows: GoodAnimals::GoodDog, Danceable, Swimmable, Animal, Walkable.

Some notable reasons for this result:
- The method lookup path goes in this order.
1. The current class
2. Any mixins, moving from last to first included
3. The inheritance chain of the current class, following the previous steps for each.
- Because `Walkable` is a mixin for the `GoodDog` superclass, it will be checked after in step 3.
- While `GoodDog` is namespaced within `GoodAnimals`, its functionality, including the `Climbable` mixin, are not included in the `GoodDog` functionality because the module was not mixed into it.

# 11

What is output and why? How does this code demonstrate polymorphism? 

```ruby
class Animal
  def eat
    puts "I eat."
  end
end

class Fish < Animal
  def eat
    puts "I eat plankton."
  end
end

class Dog < Animal
  def eat
     puts "I eat kibble."
  end
end

def feed_animal(animal)
  animal.eat
end

array_of_animals = [Animal.new, Fish.new, Dog.new]
array_of_animals.each do |animal|
  feed_animal(animal)
end
```
On line 23, local variable `array_of_animals` is initialized and references an array of custom objects: an `Animal`, `Fish` and `Dog` objects. The `each` method is called on `array_of_animals` and gets passed a `do...end` block as an argument, binding each object to the parameter `animal` throughout iteration. Upon each iteration of the block, the defined `feed_animal` method is called on the current object referenced by `animal`, which invokes each `eat` method that corresponds to the object's class, outputting `I eat.`, `I eat plankton.`, and `I eat kibble.` to the console.

This example demonstrates polymorphism via class inheritance, which occurs when a class's subclasses contain an instance method of the same name, producing a variety of results based on the implementation of the method. Each class defines a unique implementation of the `eat` instance method that overrides the `Animal` superclass's definition, outputting a unique variation of the method.

# 12

We raise an error in the code above. Why? What do `kitty` and `bud` represent in relation to our `Person` object? 

```ruby
class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

class Pet
  def jump
    puts "I'm jumping!"
  end
end

class Cat < Pet; end

class Bulldog < Pet; end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud                     

bob.pets.jump 
```
Line 28 throws a `NoMethodError` exception due to the attempt to call the `jump` method on an array object. While the `jump` instance method exists within the `Pet` class, and both `Cat` and `Bulldog` inherit from the class, `jump` can only be called on the object itself, not the array housing them. Both `kitty` and `bud` are objects of the `Cat` and `Bulldog` class, respectively, and are housed in an array object referenced by the `bob` object's `pets` attribute. In order to invoke the `jump` method on each of these objects, we should call the iterative `each` method on `bob.pets` and call `jump` on each object throughout iteration.
```ruby
bob.pets.each(&:jump)
```

# 13

What is output and why?

```ruby
class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def initialize(name); end

  def dog_name
    "bark! bark! #{@name} bark! bark!"
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name
```
Line 16 will output `bark! bark!  bark! bark!`. When the `teddy` object is instantiated, the `Dog#initialize` constructor method is called, which performs no action. Although the class inherits from `Animal`, and `Animal#initialize` assigns the `@name` instance variable, this method is not invoked due to `Dog#initialize` overriding it. Therefore, when the `dog_name` instance method is called, `@name` references `nil` which gets interpolated into the string `"bark! bark! #{@name} bark! bark!"`.

Instance variables, unlike local variables, take on the default value of `nil` when called if they have not been assigned previously.

# 14

In the code above, we want to compare whether the two objects have the same name. `Line 11` currently returns `false`. How could we return `true` on `line 11`? 

Further, since `al.name == alex.name` returns `true`, does this mean the `String` objects referenced by `al` and `alex`'s `@name` instance variables are the same object? How could we prove our case?

```ruby
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

al = Person.new('Alexander')
alex = Person.new('Alexander')
p al == alex # => true
```
There are a couple of different ways to return `true` on line 11.
1. On line 11, call the `name` getter method for both `al` and `alex` objects while comparing them.
```ruby
p al.name == alex.name
```
2. Define a `==` method within the `Person` class, which compares the current `name` with another `name` using `other` as a parameter.
```ruby
class Person
  # Omitted
  
  def ==(other)
    name == other.name
  end
end
```
This does *not* mean that they are the same objects, only that they share the same value. The `==` method only compares the values of the objects. This can be checked by changing the method to `equal?`, which checks whether the objects, strings in this case, are the same.
```ruby
p al.name.equal?(alex.name)  # => false
```

# 15

What is output on `lines 14, 15, and 16` and why?

```ruby
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "My name is #{name.upcase!}."
  end
end

bob = Person.new('Bob')
puts bob.name
puts bob
puts bob.name
```
On line 13, the `bob` object is instantiated, passing the string object `'Bob'` into the `initialize` constructor method and binding it to its parameter `name`. Within this method, the value of `name` is assigned to the `@name` instance variable, creating `'Bob'` as the `name` state for the `bob` object.

On line 14, the `name` getter method, defined by the `attr_reader` keyword, is called, which returns the value of the `name` state, `'Bob'`, outputting it to the console.

On line 15, the `bob` object is output by invocation of the `puts` method. Normally, this would output the object's ID as a string, as `puts` always converts its argument value to a string; however, because the `Person` class defines its own `to_s` method which overrides `Object#to_s`, the output will be `"My name is #{name.upcase!}."`, with the `bob` name state interpolated into the string and uppercased, outputting `My name is BOB.`

On line 16, the `name` state is called again by invocation of the `name` getter method, but its value is changed to `BOB`. This is because, when the `to_s` was called previously, the destructive `upcase!` method was called on `'Bob'`, which returned *and* mutated the state to `'BOB'`.

# 16

Why is it generally safer to invoke a setter method (if available) vs. referencing the instance variable directly when trying to set an instance variable within the class? Give an example.

-
It's generally better to use a setter method over using the instance variable directly when changing its state as the setter method may include additional functionality that allows it to be stored in a specifc manner. This will prevent repetitive code, and make for a cleaner experience.

For example, say you want to change the price of an item you have for sale. You wouldn't want the price to be a negative number, as you would have to pay someone to give it away! Defining specific rules within the setter method will help to prevent these issues from arising.

```ruby
class Instrument
  attr_reader :price

  def initialize(price)
    @price = price
  end

  def price=(new_price)
    if new_price >= 0
      @price = new_price
    else
      puts "Must be a positive number!"
    end
  end
end
```

# 17

Give an example of when it would make sense to manually write a custom getter method vs. using `attr_reader`.

-

A custom getter method may be useful when dealing with sensitive data. A program that deals with a person SSN may need access to part of the number, but you still need all numbers included in the database for verification purposes. Here, we can use a getter method that only returns the last four digits when called.

```ruby
class Person
  def initialize(name, ssn)
    @name = name
    @ssn = ssn
  end

  def ssn
    "XXX-XX-#{@ssn.to_s[5, 4]}"
  end
end

derek = Person.new('Derek', 123456789)
puts derek.ssn  # => XXX-XX-6789
```

# 18

What can executing `Triangle.sides` return? What can executing `Triangle.new.sides` return? What does this demonstrate about class variables?

```ruby
class Shape
  @@sides = nil

  def self.sides
    @@sides
  end

  def sides
    @@sides
  end
end

class Triangle < Shape
  def initialize
    @@sides = 3
  end
end

class Quadrilateral < Shape
  def initialize
    @@sides = 4
  end
end
```
Calling `Triangle.sides` returns `nil`. This is because the `@@sides` class variable is initialized on line 2 to reference `nil`, and calling the `sides` class method returns the value of `@@sides`. Because `Triangle` inherits from the `Shape` class, its behavior will match it.

When instantiating a new `Triangle` object, the `initialize` constructor method *reassigns* the value of `@@sides` to `3`, which is what will be returned when calling the `sides` instance method on the object.

This demonstrates that class variables are scoped at the *class level*, meaning any instances of the class can interact with its value.

# 19

What is the `attr_accessor` method, and why wouldn’t we want to just add `attr_accessor` methods for every instance variable in our class? Give an example.

-

The `attr_accessor` method creates both a getter and setter method for its argument attribute. For example, `attr_accessor :name` creates both `name` and `name=` methods for the `@name` instance variable.

There are several reasons you may not want to use `attr_accessor` for all your instance variables. Here are a few:
- You may want to encapsulate some of the state of your object
- You may want to be able to assign new state for an attribute, but not allow the user to receive it.
- You may want the user to be able to receive information about the state of your object, but not be able to change it.
```ruby
class Clarinetist
  attr_accessor :job
  attr_reader :instrument
  attr_writer :paycheck

  def initialize(job)
    @instrument = 'clarinet'
    @job = job
  end
end

derek = Clarinetist.new('teacher')
derek.paycheck = 'Not enough...'
```
Here, we can see and change the job of the clarinetist `derek`, which may be relevant. We can also pay him, but he may not want to share his finances with others. Lastly, we can see he plays the `'clarinet'`, but obviously cannot change that; otherwise, he would no longer be a clarinetist.

# 20

What is the difference between states and behaviors?

-

States refer to the value of an object's attributes, which may represent the cost, color, name, or more of the object. The behaviors represent what the object can do, or its methods with Ruby.
```ruby
class Musician
  def initialize(name, instrument)
    @name = name
    @instrument = instrument
  end

  def play
    puts "#{@name} is playing their #{@instrument}!"
  end
end

derek = Musician.new('Derek', 'clarinet')
derek.play
```
In this example, the `Musician` object `derek` has a state of `'Derek'` for a `name` and `'clarinet'` for the `instrument` they play. `derek` can play his instrument as a behavior by using the `play` instance method, which will output `Derek is playing their clarinet!`.

# 21

What is the difference between instance methods and class methods?

- Instance methods can be called on any instantiated object within its respective class, while class methods are only called on the class itself and can be called without any objects instantiated. While an instance method has a standard `def...end` definition within the class structure, a class method name *must* be prepended with `self.`

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

derek.play
puts Musician.total
```

## 22

What are collaborator objects, and what is the purpose of using them in OOP? Give an example of how we would work with one.

-

Collaborator objects are objects that are stored as state within another object. While these can include any kind of object, including strings, numbers, arrays, and so on, they typically reference *custom objects*, and a collaborative relationship is established between the two classes. This allows the programmer to further divide their codebase into smaller, cohesive pieces.

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

## 23

How and why would we implement a fake operator in a custom class? Give an example.

-

Many of the "operators" that are used throughout the Ruby language are methods calls *disguised* as operators through the use of *syntactical sugar*, allowing the code to be more readable and predictable. While many of the pre-existing Ruby classes and modules have their own defintions to these methods, a custom class does not by default; therefore, if we wish to implement its functionality into our program, we have to define its operation.

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

## 24

What are the use cases for `self` in Ruby, and how does `self` change based on the scope it is used in? Provide examples.

-

In Ruby, `self` represents the *calling object* and is used to disambiguate the intention of a method call. When used within an instance method, `self` represents the current instance of the class; outside of that, including within a class method defintion, it represents the class or module itself.

```ruby
module Testable
  self  # => Testable
end

class Test
  self  # => Test

  def testing
    self  # => #<Test:0x000000010eda7410>
  end
end
```

In this example, we can see three different variations of `self`. First within the `Testable` module: because `self` is not within an instance method, it references the module itself, and therefore returns `Testable`. Next, within the `Test` class: this performs in a similar manner, but instead returns the `Test` class due to its location within the `Test` class structure. Lastly, within the `testing` instance method: because this method is called on the current instance of the `Test` class, it will return the object ID of that class.

# 25

What does the above code demonstrate about how instance variables are scoped?

```ruby
class Person
  def initialize(n)
    @name = n
  end
  
  def get_name
    @name
  end
end

bob = Person.new('bob')
joe = Person.new('joe')

puts bob.inspect # => #<Person:0x000055e79be5dea8 @name="bob">
puts joe.inspect # => #<Person:0x000055e79be5de58 @name="joe">

p bob.get_name # => "bob"
```

This example demonstrates how instance variables are scoped at the *object level*, meaning they are only accessible within the current instance of the class.

On line 11, the object `bob` is instantiated from the `Person` class and passes the string `'bob'` as an argument into its `initialize` constructor method, binding it to the parameter `n`. Within the method, this value is then assigned to the initialized instance variable `@name`.

On line 12, the `joe` object undergos the same process, passing in `'joe'` instead and assigning it to the initialized `@name` instance variable. When inspecting both objects on lines 14 and 15, we can see that `@name` references the string name that was instantiated with its respective object, proving that the `@name` instance variable is only used within the current instance of its class.

On line 17, the `get_name` instance method is called on the `bob` object, which simply outputs the string value `"bob"` that was assigned to it. Rather than becoming reassigned after the instantiation of `joe`, both objects simply had their own string object assigned to it.

# 26

How do class inheritance and mixing in modules affect instance variable scope? Give an example.

-

When inheriting instance methods through either class inheritance or interface inheritance, the methods become available to the class as if it were defined there. Because of this, instance variables are able to be accessed within the instance method, even if they are located in either of these inherited containers.

```ruby
module Runable
  def run
    puts "#{@name} is running!"
  end
end

class Person
  def sleep
    puts "#{@name} is sleeping!"
  end
end

class Adult < Person
  include Runable

  def initialize(name)
    @name = name
  end
end

derek = Adult.new('Derek')
derek.run  # => Derek is running!
derek.sleep  # => Derek is sleeping!
```

# 27

How does encapsulation relate to the public interface of a class?

-

Encapsulation allows us to hide the state of an object from outside its respective class, exposing only the attributes and behaviors required by the users. In Object Oriented Programming, this is primarily achieved through Method Access Control, which allows or restricts access to these properties by the implementation of public, protected, or private methods. Because all instance methods, excluding `initialize`, are considered public method by default, their functionality is accessible outside of the class structure.

However, if these instance variables are not defined within the class structure, any attributes with assigned state are encapsulated within the class structure, as there is no way that a user can access this information from outside of the structure.

# 28

What is output and why? How could we output a message of our choice instead?

```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age  = a * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky
```

Line 13 will output the object id `#<GoodDog:0x0000000101067370>`. This output represents the object ID referenced by `sparky`, and the `puts` method invocation automatically applies the `to_s` method to the ID, converting it to a string value. To create a more readable representation of the object, we can define our own `to_s` instance method within the `GoodDog` class that will *override* the default `to_s`. Within this method, we can instruct the program to return any specific value that we'd like.

```ruby
class GoodDog
  # Omitted for brevity

  def to_s
    "A #{age} year old dog named #{name}."
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky  # => A 28 year old dog named Sparky.
```

How is the output above different than the output of the code below, and why?

```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    @name = n
    @age  = a * DOG_YEARS
  end
end
```

The output will be the same. This occurs because `self.name =` is actually a *setter method* in action, which assigns or reassigns the value of `@name`. In the second example, rather than calling the setter method within `initialize`, `@name` and `@age` are directly assigned.