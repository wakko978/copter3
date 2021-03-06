class Power < ActiveRecord::Base
  attr_accessible :name, :attack, :defense, :upkeep, :base_cost, :e_attack, :e_defense, :div_power,
    :url, :piercing, :resistance, :general_id, :general, :bonus_type, :bonus
  
  validates :name, :presence => true
  validates :attack, :defense, :piercing, :resistance, :presence => true, :numericality => { :only_integer => true }
  validates :base_cost, :upkeep, :numericality => { :only_integer => true }, :allow_nil => true
  
  has_many :spells
  belongs_to :loadoutable, :polymorphic => true
  belongs_to :general
  
  before_save :update_e_attack
  before_save :update_e_defense
  
  scope :attack, -> { where(bonus_type: 'attack') }
  scope :defense, -> { where(bonus_type: 'defense') }
  
  cattr_reader :per_page
  @@per_page = 25
  @permitted_columns = ['name','attack','defense','e_attack','e_defense','base_cost','upkeep']
  
  def is_unowned?
    !spells.exists?
  end
  
  def image_path(t)
    unless url.blank?
      url
    else
      'favor_clear.gif'
    end
  end
  
  def update_e_attack
    self.e_attack = attack + defense*0.7
  end
  
  def update_e_defense
    self.e_defense = defense + attack*0.7
  end
  
  def self.search(*args)
    options = args.extract_options!

    options[:c] = @permitted_columns.include?(options[:c]) ? options[:c] : 'e_attack'

    Power.order(options[:c] + " " + ((options[:d] == 'up') ? "ASC" : "DESC")).paginate(:page => options[:page])
  end
end
