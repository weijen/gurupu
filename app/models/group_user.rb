# == Schema Information
#
# Table name: group_users
#
#  id         :integer          not null, primary key
#  group_id   :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  role       :string(255)
#  state      :string(255)
#

class GroupUser < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  extend Enumerize

  STATE = [:wait, :invite, :join]
  ROLE = [:admin, :member]
  enumerize :state, in: STATE, predicates: true
  enumerize :role, in: ROLE, predicates: true
  validates_uniqueness_of :user_id, scope: [:group_id]

	#maca add start
  def change_state(status)
    self[:state] = status
    self.save
  end

  def change_role(role)
    self[:role] = role
    self.save
  end
  #maca add end
end
