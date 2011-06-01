class ABChoice < ActiveRecord::Base
  scope :succeed,   where(:success => true )
  scope :unsucceed, where(:success => false)

  def success!
    unless success?
      update_attributes :success => true, :succeeded_at => DateTime.now
    end
  end

  def self.succeed(identity_hash)
    self.find_by_identity_hash(identity_hash).success!
  end

  def self.reset!
    self.destroy_all
  end
end