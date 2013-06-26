class Group < ActiveRecord::Base
  include Slugable
  validates :name, presence: true, uniqueness: true, length: { in: 5..20 }

  has_many :expenses
  has_many :group_tags
  has_many :tags, through: :group_tags
  has_many :group_users
  has_many :users, through: :group_users
end
