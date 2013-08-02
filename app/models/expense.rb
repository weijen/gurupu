# == Schema Information
#
# Table name: expenses
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  cost        :integer
#  tag_id      :integer
#  slug        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  description :text(255)
#  date        :datetime
#  group_id    :integer
#  user_id     :integer
#

class Expense < ActiveRecord::Base
  extend Enumerize
  validates :name, presence: true
  validates :cost, numericality: { greater_than: 0 }
  validates :date, presence: true

  include Slugable
  belongs_to :group
  belongs_to :user
  belongs_to :tag
  scope :active, -> { where state: 'active' }
  
  STATE = [:active, :trashed]
  enumerize :state, in: STATE, predicates: true
end
