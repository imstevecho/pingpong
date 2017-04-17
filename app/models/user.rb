class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable
  has_many :games
  has_one :ranking


  def email_id
    email.partition('@').first
  end

end
