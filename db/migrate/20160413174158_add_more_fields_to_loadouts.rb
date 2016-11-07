class AddMoreFieldsToLoadouts < ActiveRecord::Migration
  def self.up
    add_column :loadouts, :amulet_piercing, :integer, default: 0
    add_column :loadouts, :amulet_resistance, :integer, default: 0
  end

  def self.down
  end
end
