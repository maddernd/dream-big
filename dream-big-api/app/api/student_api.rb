require 'grape'

class StudentApi < Grape::API
  desc 'Allow retrieval of a single student'
  get '/student/:id' do
    student_parameters = ActionController::Parameters.new(params)
      .permit(
        :id
      )

    # Auth

    student = Student.find(params[:id])
    present student, with: Entities::StudentEntity
  end

  desc 'Allow creation of a Student'
  params do
    requires :user_id, type: Integer, desc: 'student user'
    requires :firstName, type: String, desc: 'student first Name'
    requires :lastName, type: String, desc: 'student last Name'
    requires :phone, type: String, desc: 'student Phone number'
    requires :address, type: String, desc: 'student address'
    optional :student_type, type: String, desc: 'student type'
    optional :avatar_id, type: Integer, desc: 'avatar ID once created'

  end
  post '/student' do
    student_parameters = ActionController::Parameters.new(params)
      .permit(
        :firstName,
        :lastName,
        :phone,
        :address,
        :student_type,
        :user_id,
        :avatar_id
      )

    # Auth...

    createdStudent = Student.create!(student_parameters) 

    present createdStudent, with: Entities::StudentEntity
  end

  desc 'Allow updating of a student'
  params do
    
    optional :firstName, type: String, desc: 'student first Name'
    optional :lastName, type: String, desc: 'student last Name'
    optional :phone, type: String, desc: 'student Phone number'
    optional :address, type: String, desc: 'student address'
    optional :user_id, type: Integer, desc: 'student user'
    optional :student_type, type: String, desc: 'student type'
    optional :avatar_id, type: Integer, desc: 'avatar ID once created'
  end
  put '/student/:id' do
    student_parameters = ActionController::Parameters.new(params)
      .permit(
        :firstName,
        :lastName,
        :phone,
        :address,
        :student_type,
        :user_id,
        :avatar_id
      )

    # Auth

    updateStudent = Student.find(params[:id])
    updateStudent.update! student_parameters

    present updateStudent, with: Entities::StudentEntity
  end

  desc 'Delete the student with the indicated id'
  params do
    requires :id, type: Integer, desc: 'The id of the student to delete'
  end
  delete '/student/:id' do
    Student.find(params[:id]).destroy!
    true
  end

  desc 'Get all the students'
  get '/student' do
    students = Student.all

    present students, with: Entities::StudentEntity
  end
end