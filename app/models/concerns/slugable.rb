module Slugable
  extend ActiveSupport::Concern
  included do
    before_create :generate_slug
    validates :slug, uniqueness: true, length: { is: 8 }
  end

  protected
  def generate_slug
    self[:slug] = SecureRandom.hex(8)
  end
end
