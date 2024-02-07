To create an instance of the `Bag` class, we would need to call the `new` method on the class and pass in 2 arguments: a value to represent the `color` of the bag and a value to represent the `material`. Not doing so would throw an `ArgumentError` exception, as the `initialize` constructor method contains 2 parameters.

```ruby
class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

Bag.new('red', 'leather')
```