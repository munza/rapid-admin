class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  protected
  def touch_with_version(association)
    self.paper_trail.touch_with_version if persisted?
  end
end
