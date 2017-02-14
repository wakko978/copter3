class AddGuinevere < ActiveRecord::Migration
  def self.up
    general = General.find_by_name('Guinevere')
    if general
      general.update_attribute(:type,'Guinevere')
    end
  end

  def self.down
    general = General.find_by_name('Guinevere')
    if general
      general.update_attribute(:type,'General')
    end
  end
end
