Code spikes:
- rough draft
  - first attempt at class structure
  - throw away attempt
  - What you think needs to go where in classes and behaviors
- Spikes are part of agile methodology
- Don't need to go into implementation details
  - establish the different kinds of relationships between classes/methods
  - where are methods placed, which classs?
- create instances of classes without throwing errors
- Given a prompt, create a series of classes/behaviors
  - Have appropriate accessors
    - don't have to worry about behaviors

Questions
- Please express 2 ways to express polymorphism

Duck Typing
- 

Collaborator Objects
- An object that is part of another object's state
- They are typically custom class objects
- There is 'intention' to make it a collaborator

Constants
- Looks lexically
- Looks up inheritance
- Looks at main scope

module Describable
  def describe_shape
    "I am a #{self.class} and have #{SIDES} sides."
  end
end

class Shape
  # SIDES = 9
  include Describable

  def self.sides
    self::SIDES
  end
  
  def sides
    # SIDES
    self.class::SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4
end

class Square < Quadrilateral; end

p Square.sides 
p Square.new.sides 
p Square.new.describe_shape 


# What is output and why? What does this demonstrate about constant scope? What does `self` refer to in each of the 3 methods above? 

# Constant Resolution Path
  # 1. Searches Lexically
  # 2. Searches the Inheritance Chain
  # 3. Checks the Top Scope   

-------------------------

# SPOT SESSION with ESTHER

Encapsulation
- The data is encap in the object made in the class
- Restricts access to the state of an object
- OO gives us a means to encasulate data
  - level of abstraction
- MAC is a form of encapsulation
  - Only for instance methods

POLYMORPHISM
- Thru inheritance
  - Class inheritance
  - Interface inheritance
- Duck typing
- Needs to be done with intention

- Constant resolution operator
  - searches location specified
    - ONLY the specific container
  - searches inheritance chain of the specified container
  - Does NOT search the top level ***

Constant Problem to play around with

```ruby
WHEELS = 42

module Drivable
  # WHEELS = 21

  class Car
    # WHEELS = 4
    # include Drivable

    def how_many
      WHEELS
    end
  end
  
  class Motorcycle
    WHEELS = 2

    def how_many
      Drivable::Car::WHEELS
    end
  end
end



mazda = Drivable::Car.new
honda = Drivable::Motorcycle.new

puts mazda.how_many #=> 21
# puts Drivable::Car.ancestors
puts honda.how_many
```

CALEB

https://www.notion.so/RB120-92490135331c4fe299a72bb523bc05cb
https://docs.google.com/document/d/10JvX-ArkfF8fIWQu8wPaYt7JJHrv_5E0gM0I2uPirwI/edit#
https://github.com/gontzess/rb120_object_oriented_programming/blob/master/assessment_prep/oral_practice_questions.md
https://drive.google.com/file/d/1pE1St7TKAqiVPmu-fwuQfiqWrSqxflSN/view
https://www.scott-hoecker.dev/posts/code_examples/
https://www.scott-hoecker.dev/posts/rb129-written-assessment-study-questions/
https://docs.google.com/document/d/1Xf6X6jXi6FhCIR4HLEHpQ5xpY9YEZrq2b7c8Lz2kW4I/edit
https://docs.google.com/document/d/10Lg5TfMMqtADcHlPKiDUBqPDMB6Q63_Fs_uVGQG3ybQ/edit
https://jd-launch-school.gitlab.io/launch-school/posts/how-to-take-written-assessment-for-launch-school/
https://medium.com/launch-school/preparing-for-the-129-interview-assessment-4e6c208ce2e4
https://seanrichardson95.medium.com/how-i-prepped-for-the-rb129-written-assessment-79b607ec0d88
https://dev.to/sunnyb/public-vs-private-vs-protected-9hk
https://www.codewithjason.com/purpose-private-methods-use/
https://launchschool.com/posts/4113bb2d
https://medium.com/@wayne_olson/a-mental-model-for-understanding-encapsulation-in-ruby-9c762cde8f05
https://cirw.in/blog/constant-lookup.html
https://launchschool.com/posts/fcaa7381

Tree-style tabs
https://chromewebstore.google.com/detail/tree-style-tab/oicakdoenlelpjnkoljnaakdofplkgnd?pli=1

Polymorphism
- Inheritance
  - Class
  - Interface inheritance
-Duck
  - responds 'differently' to a common interface

Encapsulation
- achieved by creating objects
- form of data protection
- Focus more on OOP side with MAC

IDE

SPOT with Kana

- creating objects encapsulates state

Encapsulation lets us hide the internal representation of an object from the outside and only expose the methods and properties that users of the object need. We can use method access control to expose these properties and methods through the public (or external) interface of a class: its public methods.

# class Coffee
#   def grind
#     puts "Grinding beans into grounds."
#   end
# end

# class Pepper
#   def grind
#     puts "Grinding pepper on my steak."
#   end
# end

# [Coffee.new, Pepper.new].each(&:grind)

Spikes Problems

## CARS SPIKE
# There is a vehicle company called Cool Car Factory
# There are 3 trucks and two cars there.
# A blue garbage truck has orange wheels and picks up garbage 
# An orange recycling truck has blue wheels and picks up recycling 
# A purple car called Do Not Touch Anything Dirty has black wheels and if it touches something dirty says "hey don't touch any dirty stuff!" 
# a green race car that races and has black wheels 
# A red firetruck with black wheels that puts out fires 
# All truck/car's of these types would have these same attributes and you can pass only one argument on instantiation 
# all trucks can carry heavy stuff 
# all cars and the firetruck can go fast 
# all vehicles can drive 
# calling puts on an object of any class should return a sentence describing that object 

## PRESCHOOL SPIKE
# Inside a preschool there are children, teachers, class assistants, a principle, janitors, and cafeteria workers. 
# Both teachers and assistants can help a student with schoolwork and watch them on the playground. 
# A teacher teaches and an assistant helps kids with any bathroom emergencies. Kids themselves can learn and play. 
# A teacher and principle can supervise a class. 
# Only the principle has the ability to expel a kid. 
# Janitors have the ability to clean. 
# Cafeteria workers have the ability to serve food. 
# Children, teachers, class assistants, principles, janitors and cafeteria workers all have the ability to eat lunch.

## DENTAL OFFICE SPIKE
# There's a dental office called Dental People Inc.  Within this office, there's 2 oral surgeons, 2 orthodontists, 1 general dentist.
# Both general dentists and oral surgeons can pull teeth. Orthodontists cannot pull teeth.  Orthodontists straighten teeth.
# All of these aforementioned specialties are dentists. All dentists graduated from dental school.  Oral surgeons place implants.
# General dentists fill teeth

## GOLDEN GIRLS SPIKE
# The girls live in a house with an address of 6151 Richmond Street Miami, FL. There are four inhabitants of the house:
# - Dorothy Zbornak
# - Blanche Deveraux
# - Rose Nylund
# - Sofia Petrillo

# All of the girls are American, except for Sofia-- she's Italian. All the girls work, except for Sofia. All of them are widows, except for Dorothy.
# - Only Dorothy stays home on Saturday evenings.
# - Only Rose has a long-term boyfriend.
# - Only Blanche dates younger men.
# - All of the girls are over 50.
# - Dorothy has an ex-husband by the name of Stan Zbornak.

## STORE INVENTORY MANAGEMENT SYSTEM
# You are tasked with implementing a program that simulates a basic inventory management system for a small store. The store has a limited number of items in stock, and the system should allow for adding items to the inventory, updating the stock levels, and retrieving the current stock levels for each item.

# Your program should have the following functionalities:
# Add an item to the inventory: Allow the user to input the name, price, and initial stock level for a new item, and add it to the inventory. 
# Update stock levels: Allow the user to update the stock level of an existing item in the inventory by specifying the item name and the new stock level.
# Retrieve stock levels: Allow the user to retrieve the current stock level for a specific item in the inventory by specifying the item name.

## RESTAURANT SPIKE
# Restaurant has staff, and they all work and get paid
# Restaurant has servers that wear white shirts, serve orders and interact with customers
# Managers wear black shirts, can check inventory, serve orders and interact with customers
# Cooks can cook and check inventory, wear striped shirts
# Hosts seat guests and distribute menus, and interact with customers

# TA Session with Brandi

- Format is similar
- Longest assessment
- About 20 questions
- Much more conceptual
- Why are things useful
- How well can you explain concept
- Lean on the examples your comfortable
- DOn't need to talk about the low level details
- Mention that a variable references an object, but then just call it by the object name
- Meeting requirements for the last question
- Be more focused on the concept rather than being extremely precise
- If a relationship, we're talking about the OO relationship

Questions:
- What does self refer to in ruby
  - self outside of the instance method refers to the class

- What is the difference between public and private methods?
  - initialize constructor method is a *private method* by default

- Tell me about class inheritance
  - What is the purpose on it?
  - Inheritance at its core is about behavior sharing
    - More generic super classes to more specific subclasses

- A class
- A subclass that does not have access to that behavior
- 2 subclasses that need it

- Container modules?
- namespacing
- interface inheritance

```ruby
module Toys
  class Truck; end
  class Car; end
end

Toys::Truck.new

module Vehicles
  class Truck; end
  class Car; end
end

Vehicles::Truck.new
```


