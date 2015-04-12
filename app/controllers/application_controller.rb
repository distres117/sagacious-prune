class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
  	if session[:user_id]
  		@current_user ||= User.find(session[:user_id])
  	end
  end

  helper_method :current_user

  def authenticate_user
  	redirect_to login_path unless current_user
  end

  def init_course
    course = current_user.courses.create(name: "Unamed Course")
    #create default objects
    course.assignment_types.create(assign_type: "Homework", percentage: 0.2, format: "Check")
    course.assignment_types.create(assign_type: "Quiz", percentage: 0.4, format: "Letter")
    course.assignment_types.create(assign_type: "Participation", percentage: 0.4 , format:"Letter")
    course.assignments.create(assign_type: "Participation", name: "Participation", due: Time.now )
    return course
  end

  
end
