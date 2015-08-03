class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :properties
  validates :email, uniqueness: true

  def self.authenticate(email, password)
    @user = User.find_by_email(email)
    if @user == []
      nil
    elsif @user.password == password
      return @user
    else
      nil
    end
  end

end
