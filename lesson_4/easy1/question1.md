Every example is considered an object. In Ruby, an object is anything that is said to have a value.

1. `true` is a Boolean object
2. `"hello"` is a String object
3. `[1, 2, 3, "happy days"]` is an Array object
4. `142` is an integer object

To check which class each belongs to, you can call the `class` method on each value.

```ruby
true.class  # => TrueClass
"hello".class  # => String
[1, 2, 3, "happy days"].class  # => Array
142.class  # => Integer
```