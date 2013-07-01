class GroupUser < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

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
