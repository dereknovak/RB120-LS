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
- While `GoodDog` is namespaced within `GoodAnimals`, its functionality, including the `Climbable` mixin, are not included in the `GoodDog` functionality.