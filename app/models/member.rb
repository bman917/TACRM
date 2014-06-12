class Member < ActiveRecord::Base
  has_one :account, through: :profile
  belongs_to :profile
  belongs_to :group
  validates :profile, presence: true

  def owner
    group.profile
  end
end
