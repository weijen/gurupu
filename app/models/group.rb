class Group < ActiveRecord::Base
  include Slugable
  validates :name, presence: true, uniqueness: true, length: { in: 5..20 }
  validates :description, presence: true, length: { maximum: 255 }

  has_many :expenses
  has_many :group_tags
  has_many :tags, through: :group_tags
  has_many :group_users
  has_many :members, through: :group_users, source: :user
  has_many :owner, -> { where("group_users.role = 'admin'") },
           through: :group_users, source: :user


  def add_owner(user)
    group_users.create(user: user, role: 'admin', state: 'joined')
  end

  def editable_by?(user)
  end

  def set_state_frozen
    self[:state] = 'frozen'
  end

  def set_state_active
    self[:state] = 'active'
  end
  
  #maca add start
  def change_state
    if self[:state] == 'frozen' 
      self[:state] = 'active' 
    else
      self[:state] = 'frozen' 
    end
    self.save    
  end
  #maca add end

end
