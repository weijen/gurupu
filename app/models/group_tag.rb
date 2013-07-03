# == Schema Information
#
# Table name: group_tags
#
#  id         :integer          not null, primary key
#  group_id   :integer
#  tag_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

class GroupTag < ActiveRecord::Base
  belongs_to :group
  belongs_to :tag
end
