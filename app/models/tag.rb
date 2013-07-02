# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  slug       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  is_default :boolean
#

class Tag < ActiveRecord::Base
  include Slugable
  validates :name, presence: true

  has_many :expenses
  has_many :group_tags
  has_many :groups, through: :group_tags
end
