To inherit from the `Game` class, you can add `< Game` after the bingo class defintion, allowing all of its behaviors to be accessible to the `Bingo` class. This is an example of class inheritance.

```ruby
class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end
```