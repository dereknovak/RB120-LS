The error is thrown due to the `hi` instance method being labeled as a private method. Because the method is called on an object outside of the `Person` class, that being `bob`, the method is unable to be used.

This can be solved simply by removing `hi` from the private instance methods.

```ruby
class Person
  def hi
    puts "Hello!"
  end
end

bob = Person.new
bob.hi
```