=begin
- Create a class Student with attributes name and grade
- grade should not have a public getter method
- Create better_grade_than? method
=end

class Student
  def initialize(n, g)
    @name = n
    @grade = g
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  def grade
    @grade
  end
end

joe = Student.new('Joe', 97)
bob = Student.new('Bob', 95)

puts "Well done!" if joe.better_grade_than?(bob)
