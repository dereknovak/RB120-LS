When creating a new class, Ruby automatically provides a `to_s` method, inherited from the `Object` class. This method outputs both the class name and the object instance's ID. We can define our own `to_s` method within the class that will be prioritize over its superclass in order to return a different result.

For this particular problem, we can define `to_s` to simply return the string `"I am a #{@type} cat"`, which interpolates the type state of the cat initialized upon instantiation.

To showcase this change, we can simply invoke the `puts` method and pass the `tabby` object as an argument, which will output the string to the console.

```ruby
class Cat
  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{@type} cat"
  end
end

tabby = Cat.new('tabby')
puts tabby
```