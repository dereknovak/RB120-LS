## PRESCHOOL SPIKE
# Inside a preschool there are children, teachers, class assistants, a principle, janitors, and cafeteria workers. 
# Both teachers and assistants can help a student with schoolwork and watch them on the playground. 
# A teacher teaches and an assistant helps kids with any bathroom emergencies. Kids themselves can learn and play. 
# A teacher and principle can supervise a class. 
# Only the principle has the ability to expel a kid. 
# Janitors have the ability to clean. 
# Cafeteria workers have the ability to serve food. 
# Children, teachers, class assistants, principles, janitors and cafeteria workers all have the ability to eat lunch.

=begin

Preschool
- children +++
  - Can learn +++
  - Can play +++
  - Can eat lunch +++
- teachers
  - Can help students with schoolwork
  - Can watch them on the playground
  - Can teach
  - Can supervise a class
  - Can eat lunch
- class assistants
  - Can help students with schoolwork
  - Can watch them on the playground
  - Can help students with bathroom emergencies
  - Can eat lunch
- a principal +++
  - Can supervise a class
  - Can eat lunch
- janitors +++
  - Can clean
  - Can eat lunch
- cafeteria workers +++
  - Can serve food
  - Can eat lunch

=end
module Supervisable
  def supervise
    puts "I'm supervising the kiddos!"
  end
end

module Feedable
  def eat_lunch
    puts "It's lunch time!"
  end
end

class Preschool
  def initialize
    @staff = []
    @students = []
  end

  def hire_staff(staff_member)
    @staff << staff_member
  end

  def onboard_student(student)
    @students << student
  end

  def expel_student(student)
    @students.delete(student)
  end
end

class Staff
  include Feedable
end

class ClassroomStaff < Staff
  def help_with_homework
    puts "I'm helping students with homework!"
  end

  def keep_watch
    puts "I'm watching students on the playground!"
  end
end

class Student
  include Feedable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def learn
    puts "I'm learning!"
  end

  def play
    puts "I'm playing!"
  end
end

class Teacher < ClassroomStaff
  include Supervisable

  def teach
    puts "I'm teaching!"
  end
end

class Assistant < ClassroomStaff
  def help_with_bathroom
    puts "I'm helping with bathroom emergencies!"
  end
end

class Principal < Staff
  include Supervisable

  def expel(student)
    puts "I'm expelling #{student.name}!"
  end
end

class Janitor < Staff
  def clean
    "I'm cleaning!"
  end
end

class CafeteriaWorker < Staff
  def serve_food
    "I'm serving food!"
  end
end

