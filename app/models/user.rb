class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true

  has_paper_trail :meta => {:description => :display}

  def display
  	"User: #{self.username}"
  end

  def admin?
  	self.role == "Admin"
  end
end
