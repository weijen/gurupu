class Tag < ActiveRecord::Base
  include Slugable
  validates :name, presence: true

  has_many :expenses
  has_many :group_tags
  has_many :groups, through: :group_tags
end
