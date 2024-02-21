## CARS SPIKE
# There is a vehicle company called Cool Car Factory +++
# There are 3 trucks and two cars there. +++
# A blue garbage truck has orange wheels and picks up garbage +++
# An orange recycling truck has blue wheels and picks up recycling +++
# A purple car called Do Not Touch Anything Dirty has black wheels and if it touches something dirty says "hey don't touch any dirty stuff!" +++
# a green race car that races and has black wheels +++
# A red firetruck with black wheels that puts out fires +++
# All truck/car's of these types would have these same attributes and you can pass only one argument on instantiation +++
# all trucks can carry heavy stuff  +++
# all cars and the firetruck can go fast  +++
# all vehicles can drive +++
# calling puts on an object of any class should return a sentence describing that object +++

class CoolCarFactory
  attr_reader :vehicles

  def initialize
    @vehicles = []
  end

  def <<(vehicle)
    @vehicles << vehicle
  end
end

class Vehicle
  def initialize(color)
    @color = color
  end

  def drive
    puts "Driving my #{type}!"
  end

  def to_s
    "A #{color} #{type} with #{wheel_color} wheels."
  end

  private

  attr_reader :color, :type, :wheel_color, :ability
end

class Car < Vehicle
  SPEED = 'fast'
  
  def initialize(color)
    super
    @type = 'car'
    @wheel_color = 'black'
    @ability = 'very clean'
  end

  def touch_something_dirty
    puts "Hey don't touch anything dirty!" if ability == 'very clean'
  end
end

class RaceCar < Car
  def initialize(color)
    super
    @ability = 'standard clean'
  end
end

class Truck < Vehicle
  HEAVY_LIFTING = true

  def initialize(color)
    super
    @type = 'truck'
  end
end

class FireTruck < Truck
  SPEED = 'fast'
  def initialize(color)
    super
    @wheel_color = 'black'
    @ability = 'put out fires'
  end
end

class RecyclingTruck < Truck
  def initialize(color)
    super
    @wheel_color = 'blue'
    @ability = 'picks up recycling'
  end
end

class GarbageTruck < Truck
  def initialize(color)
    super
    @wheel_color = 'orange'
    @ability = 'picks up garbage'
  end
end

cool_car_factory = CoolCarFactory.new

garbage_truck = GarbageTruck.new('blue')
recycling_truck = RecyclingTruck.new('orange')
fire_truck = FireTruck.new('red')
racecar = RaceCar.new('green')
do_not_touch_anything_dirty = Car.new('purple')

[garbage_truck, recycling_truck, fire_truck, racecar, do_not_touch_anything_dirty].each do |vehicle|
  cool_car_factory << vehicle
  vehicle.drive
end

do_not_touch_anything_dirty.touch_something_dirty

racecar.touch_something_dirty