class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true

  has_paper_trail :meta => {:description => :display}, 
  		:ignore => [:last_sign_in_ip, :current_sign_ip, 
  					:current_sign_in_at, :last_sign_in_at,
  					:remember_created_at, :reset_password_token, 
  					:reset_password_sent_at, :sign_in_count, :updated_at ]

  def display
  	"User: #{self.username}"
  end

  def admin?
    self.role.try(:casecmp, "Admin") == 0
  end

  def viewer?
    self.role.try(:casecmp, "Viewer") == 0
  end

  def moderator?
    self.role.try(:casecmp, "Moderator") == 0
  end
end
