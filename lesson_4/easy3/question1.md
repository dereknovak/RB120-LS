Because both `Hello` and `Goodbye` are subclasses of the `Greeting` class, they both are provided the `greet` instance method defined on line 2. When calling the `hi` instance method on the instantiated `Hello` object `hello`, the `greet` method is invoked, passing in `"Hello"` as an argument. The `greet` method simply outputs the argument value, so case 1 will output `Hello`.

For case 2, the `bye` instance method is attempted to be called on the same `hello` object, however `bye` was never initialized within the `Hello` class. Although both `Hello` and `Goodbye` inherit from the same `Greeting` superclass, their methods are not shared with each other. Because of this, Ruby will throw a `NoMethodError` complaint.

For case 3, `greet` is called on the `hello` object. While this would normally be possible, there are no arguments passed into the method, and `greet` requires one. Because of this, Ruby will throw an `ArgumentError` complaint.

Case 4 fixes the previous case by providing the string `"Goodbye"` as an argument. This will output `Goodbye` to the console.

Lastly, case 5 calls the `hi` method directly on the `Hello` class itself. Because `hi` is an instance method and `Hello` is a class, Ruby will throw a `NoMethodError` complaint, as it is unable to find a `hi` class method within the `Hello` class.