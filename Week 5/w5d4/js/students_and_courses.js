function Student(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.courses = []
  
}

Student.prototype.name = function() {
  return this.firstName + " " + this.lastName
}

Student.prototype.enroll = function(course) {
  this.courses.forEach(function(c){
    if(c === course){
      return
    }
  });
  
  this.courses.push(course)
  course.students.push(this) 
}

function Course(department, credits, days, time) {
  this.department = department;
  this.credits = credits;
  this.days = days;
  this.time = time;
  this.students = [];
}

function intersection(x, y) {
        x.sort();
        y.sort();
        var i = j = 0;
        var ret = [];
        while (i < x.length && j < y.length) {
            if (x[i] < y[j]) i++;
            else if (y[j] < x[i]) j++;
            else {
                ret.push(i);
                i++, j++;
            }
        }
        return ret;
}

Course.prototype.isConflicting = function(course) {
  intersection(this.days, course.days).forEach(function(day) {
    console.log("intersect", intersection(this.days, course.days))
    if(this.time == course.time)
      return true
  })
  return false
}

Course.prototype.addStudent = function(student) {
  student.enroll(this)
}


dave = new Student("Dave", "Donkey")
biology = new Course("science", 5, ["mon"], 5)
geology = new Course("science", 5, ["mon"], 5)
dave.enroll(biology)

console.log(dave.name())
console.log(biology)
console.log(dave.courses)
console.log(biology.students)

console.log(biology.isConflicting(geology))