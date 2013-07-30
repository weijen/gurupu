# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
    end
  end

  validates :uid, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :group_users
  has_many :groups, through: :group_users

  def join!(group)
    groups << group
  end

  def quit!(group)
    groups.delete(group)
  end

  def is_member_of?(group)
    gp = group_user(group)
    gp && gp.state.join?
  end

  def is_owner_of?(group)
    group_user(group).role.admin?
  end

  def is_waiting?(group)
    group_user(group).state.wait?
  end

  def is_inviting?(group)
    group_user(group).state.invite?
  end

  private
  def group_user(group)
    group_users.find_by(group: group)
  end
end
