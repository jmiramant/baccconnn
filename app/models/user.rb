require 'bcrypt'


class User < ActiveRecord::Base
  has_many :urls

  include BCrypt

  #valid Email

  #blowfish auth
    # users.password_hash in the database is a :string
  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.create(params)
    @user = User.new(params)
    @user.password = params[:password_hash]
    @user.save!
  end


# Authenticating a user
  # def login
  #   @user = User.find_by_email(params[:email])
  #   if @user.password == params[:password]
  #     session[:logged_in_user_id] = @user.id
  #     redirect "/secret"
  #   else
  #     redirect "/"
  #   end
  # end

end
