class Employee
  attr_accessor :name, :title, :salary, :boss
  
  def initialize(salary, boss = "b", name = "a", title = "1")
    @name, @title, @salary = name, title, salary
    @boss = boss
  end
  
  def bonus(multiplier)
    @bonus = @salary  * multiplier
  end
end

class Manager < Employee
  
  attr_accessor :employees
  def initialize(salary)
    super(salary)
    @employees = []
  end
  
  def bonus(multiplier)
    total = 0
    @employees.each do |e|
      total += get_total_salary(e)
    end
    total * multiplier
  end
  
  def get_total_salary(employee)
    total = employee.salary
    return total if employee.class == Employee
    employee.employees.each do |e|
       total += get_total_salary(e)
    end
    
    total
  end
  
end


# e1 = Employee.new(10)
# e2 = Employee.new(10)
# e3 = Employee.new(10)
# e4 = Employee.new(10)
#
# employees = [e1,e2,e3,e4]
# m1 = Manager.new(100)
# m1.employees = employees
#
# e5 = Employee.new(10)
# e6 = Employee.new(10)
#
# m2 = Manager.new(200)
#
# m2.employees = [e5,e6,m1]
#
# p m2.bonus(2)




    
    
  
  