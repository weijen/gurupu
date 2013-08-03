# == Schema Information
#
# Table name: invitations
#
#  id        :integer          not null, primary key
#  sender_id :integer
#  group_id  :integer
#  email     :string(255)
#  slug      :string(255)
#

class Invitation < ActiveRecord::Base
  include Slugable
  belongs_to :group
  belongs_to :user, foreign_key: 'sender_id'

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates_uniqueness_of :group_id, scope: [:email]

end
