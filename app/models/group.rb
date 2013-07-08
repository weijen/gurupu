# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text(255)
#  slug        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  state       :string(255)
#

class Group < ActiveRecord::Base
  include Slugable
  extend Enumerize
  validates :name, presence: true, uniqueness: true, length: { in: 5..20 }
  validates :description, presence: true, length: { maximum: 255 }

  has_many :expenses
  has_many :group_tags
  has_many :tags, through: :group_tags
  has_many :group_users
  has_many :members, through: :group_users, source: :user
  has_many :owners, -> { where("group_users.role = 'admin'") },
           through: :group_users, source: :user

  STATE = [:active, :frozen, :trashed]
  enumerize :state, in: STATE, predicates: true

  def add_owner(user)
    group_users.create(user: user, role: 'admin', state: 'joined')
  end

  def editable_by?(user)
  end

end
