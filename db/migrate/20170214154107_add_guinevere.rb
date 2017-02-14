class AddGuinevere < ActiveRecord::Migration
  def self.up
    General.find_by_name('Guinevere').update_attribute(:type,'Guinevere')
  end

  def self.down
    General.find_by_name('Guinevere').update_attribute(:type,'General')
  end
end
