class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @current_speed = 0
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
end

mazda = MyCar.new(2016, "gray", 'Mazda')

p mazda.color
mazda.color = 'pink'
p mazda.color

p mazda.year

