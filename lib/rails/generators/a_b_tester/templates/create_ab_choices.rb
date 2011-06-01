class CreateAbChoices < ActiveRecord::Migration
  def self.up
    create_table :ab_choices do |t|
      t.string      :identity_hash
      t.boolean     :success, :default => false
      t.string      :choice
      t.datetime    :succeeded_at
      t.timestamps
    end
  end

  def self.down
    drop_table :ab_choices
  end
end
