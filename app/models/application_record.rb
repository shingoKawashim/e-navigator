class ApplicationRecord < ActiveRecord::Base
  ALIVE = 0
  DELETED = 1

  self.abstract_class = true

  def soft_delete
    self.deleted    = DELETED if respond_to?(:deleted)
    self.deleted_at = Time.now if respond_to?(:deleted_at)
    save(validate: false)
  end

  def all_destroy
    soft_delete
  end

  class << self
    def alive_records
      where(deleted: ALIVE)
    end
  end
end
