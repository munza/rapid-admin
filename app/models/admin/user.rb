class Admin::User < ApplicationRecord
	has_and_belongs_to_many :groups, class_name: Admin::Group

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  			 # :confirmable, :lockable, :timeoutable, :omniauthable

  scope :admin, ->{ where(is_admin: true) }

  after_create { |admin| admin.send_reset_password_instructions }

  def password_required?
    new_record? ? false : super
  end

  def name
  	"#{first_name} #{last_name}"
  end

  def is_admin?
  	is_admin
  end
end
