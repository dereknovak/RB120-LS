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

