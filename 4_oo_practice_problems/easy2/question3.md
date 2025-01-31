To find the locations that Ruby searches when a method is called, you can call the `ancestors` class method on the class that the method is within. This will return the method lookup path for any methods within the class, to which Ruby will execute the first one that it finds on that path.

The method lookup chain for both `Orange` and `HotSauce` is as follows:
1. `Orange` or `HotSauce` class, whichever is being called
2. `Taste` module
3. `Object` class
4. `Kernel` module
5. `BasicObject` class