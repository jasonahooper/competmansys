class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://ancient-river-4609.herokuapp.com/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to the Competition Management System')
  end
end