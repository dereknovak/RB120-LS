To create two separate instances of the same class, simply call the `new` method twice on the class, with each iteration passing in a different `age` and `name`, assigning each to their own object. Then, to check that they are different object instances, you can call the `name` and `age` getter methods, which will output both for each.

```ruby
susie = AngryCat.new(10, 'Susie')
brownie = AngryCat.new(8, 'Brownie')

susie.name
susie.age

brownie.name
brownie.age
```