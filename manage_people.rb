def create_teacher
  print "teacher's specialization: "
  specialization = @input.specialization_input
  print "teacher's age: "
  age = @input.age_input
  print "teacher's name: "
  name = @input.name_input
  teacher = Teacher.new(age, name, specialization, parent_permission: true)
  @people << teacher
  puts 'You have successfully registered a Teacher'
end

def create_student
  print 'Age: '
  age = @input.age_input
  print 'Name: '
  name = @input.name_input
  print 'Has parent permission? [Y/N]'
  parent_permission = @input.parent_permission_input

  case parent_permission
  when 'n'
    student = Student.new(nil, age, name, parent_permission: false)
    @people << student
  when 'y'
    student = Student.new(nil, age, name, parent_permission: true)
    @people << student
  else
    'You have entered an invalid option'
  end

  puts 'You have successfully registered a Student'
end
