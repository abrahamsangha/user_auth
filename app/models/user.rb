class User < ActiveRecord::Base
  # Remember to create a migration!
  validates :name, presence: true
  validates :email, presence: true
  validates :email, format: { with: /.+@.+\..+/}

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    @user = User.find_by_email(email)
    if @user && @user.password == password
      @user
    else
      redirect to '/'
    end
  end
end
