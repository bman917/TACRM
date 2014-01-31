class Group < ActiveRecord::Base
  has_one :profile, through: :account
  belongs_to :account
  has_many :members, dependent: :destroy
end
