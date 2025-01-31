The exception is thrown due to the method `name=` not being defined within the class `Person`. The `attr_reader` method creates a *getter* method, but not a *setter* method, which is the version that the error is referencing.

This can be fixed by changing `attr_reader` to `attr_accessor`, allowing both the viewing and changing of the variable.

```ruby
class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
```