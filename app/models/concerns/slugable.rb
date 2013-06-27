module Slugable
  extend ActiveSupport::Concern
  included do
    before_create :generate_slug
    validates :slug, uniqueness: true
  end

  def to_param
    slug
  end

  protected
  def generate_slug
    self[:slug] = SecureRandom.hex(8)
  end
end
