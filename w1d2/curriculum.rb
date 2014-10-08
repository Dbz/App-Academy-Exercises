class Student
  attr_accessor :first, :last
  attr_reader :courses
  
  def initialize(first, last)
    @first = first
    @last = last
    @courses = []
  end
  
  def name
    "#{first} #{last}"
  end
  
  def enroll(course)
    raise "Courses conflict!" if @courses.any?{|c| c.conflicts_with? course}
    @courses << course unless @courses.include? course
    course.add_student(self) unless course.students.include? self
  end
  
  def course_load
    load = Hash.new(0)
    @courses.each do |c|
      load[c.department] += c.credits
    end
    load
  end
end
class Course
  attr_accessor :name, :department, :credits, :days, :block
  attr_reader :students
  
  def initialize(name, department, credits, block, days)
    @name = name
    @department = department
    @credits = credits
    @students = []
    @days = days
    @block = block
  end

  def add_student(student)
    student.enroll(self) unless student.courses.include? self
    @students << student unless @students.include? student
  end
  def conflicts_with? other_course
    p self.days
    !(self.days & other_course.days).empty? and self.block == other_course.block
  end
end

science = Course.new("Chem", "Science", 4, 1, [:mon])
science2 = Course.new("Physics", "Science", 3, 1, [:mon, :tue])
student = Student.new("Bob", "Burt")
p student.name
student.enroll(science)
p student.course_load
p science.students
student.enroll(science2)
p student.course_load

p science.conflicts_with? science2