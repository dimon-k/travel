class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  has_many :comments

  def soft_delete
    # assuming you have deleted_at column added already
    update_attribute(:deleted_at, Time.current)
  end
  
end
