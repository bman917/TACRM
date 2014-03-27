class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true

  has_paper_trail :meta => {:description => :display}, 
  		:ignore => [:last_sign_in_ip, :current_sign_ip, 
  					:current_sign_in_at, :last_sign_in_at,
  					:remember_created_at, :reset_password_token, 
  					:reset_password_sent_at, :sign_in_count, :updated_at ]

  def display
  	"User: #{self.username}"
  end

  def admin?
  	self.role == "Admin"
  end
end
