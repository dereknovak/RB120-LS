class Vehicle
  attr_accessor :color
  attr_reader :year, :model

  @@objects_created = 0

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @current_speed = 0
    @@objects_created += 1
  end

  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  def speed_up(amount)
    @current_speed += amount
    puts "You sped up #{amount} mph."
  end

  def brake(amount)
    @current_speed -= amount
    puts "You pressed the brakes for #{amount} mph."
  end

  def turn_off
    @current_speed = 0
    puts "Let's turn this puppy off."
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks amazing!"
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas."
  end

  def to_s
    "It's a #{year} #{color} #{model}. Sweet!"
  end

  def self.objects_created
    puts "A total of #{@@objects_created} objects have been created in the Vehicle class."
  end
end

class MyCar < Vehicle
  DIFFERENT = {type: 'sedan', trunk: 'hatchback'}
end

class MyTruck < Vehicle
  DIFFERENT = {type: 'truck', trunk: 'bed'}
end

mazda = MyCar.new(2016, 'gray', 'Mazda')
ford = MyTruck.new(2002, 'red', 'Ford')

Vehicle.objects_created
