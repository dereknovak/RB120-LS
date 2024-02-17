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
