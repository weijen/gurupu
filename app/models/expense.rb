class Expense < ActiveRecord::Base
  include Slugable
  belongs_to :group
  belongs_to :tag

  validates :name, presence: true
  validates :cost, numericality: { greater_than: 0 }

  def to_param
    slug
  end
end
