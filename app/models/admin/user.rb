class Admin::User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  			 # :confirmable, :lockable, :timeoutable, :omniauthable

  def to_s
  	"#{first_name} #{last_name}"
  end
end
