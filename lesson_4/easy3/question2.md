This error can be fixed by adding a `hi` class method to the `Hello` class. A class method is always prepended by `self.`. Class methods only have access to other class methods, so an additional `self.greet` class method would have to be defined if the desired output is the same.

```ruby
class Greeting
  def greet(message)
    puts message
  end

# highlight
  def self.greet(message)
    puts message
  end
# endhighlight
end

class Hello < Greeting
  def hi
    greet("Hello")
  end

# highlight
  def self.hi
    greet("Hello")
  end
# endhighlight
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

Hello.hi
```