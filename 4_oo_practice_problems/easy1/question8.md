`self`, when used with a method definition within a class, dictates that the method is a *class method*. Because of this, `self` refers to the class itself; in this case, it is referring to `Cat`. Rather than calling `cats_count` on an object instance of the `Cat` class, you would call it on the `Cat` class itself.

```ruby
class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

Cat.cats_count
```