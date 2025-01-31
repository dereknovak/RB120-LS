Along with calling the setter method using the `self` prefix, Ruby allows us to reassign the instance variable from within this method. To accomplish this, rather than using `self.age`, you can simply use `@age`, though its typically a better idea to leave the current syntax.

```ruby
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    @age += 1
  end
end
```