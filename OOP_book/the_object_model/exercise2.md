A Module is a collection of behaviors that are avaiable in other classes, by way of mixins. Within these modules, instance methods are created that are "mixed-in" with other classes, allowing those methods to be used.

```ruby
module Speak
  def speak(sound)
    puts sound
  end
end

class HumanBeing
  include Speak
end

bob = HumanBeing.new
bob.speak('Hello!')  # => Hello!
```