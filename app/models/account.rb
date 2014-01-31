class Account < ActiveRecord::Base
  belongs_to :profile
  has_many :groups, dependent: :destroy
end
