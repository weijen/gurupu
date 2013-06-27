class Expense < ActiveRecord::Base
  validates :name, presence: true
  validates :cost, numericality: { greater_than: 0 }
  validates :description, presence: true, length: { maximum: 255 }
  validates :date, presence: true


  include Slugable
  belongs_to :group
  belongs_to :user
  belongs_to :tag

end
