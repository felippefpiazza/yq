class Establishment < ActiveRecord::Base
  validates :name, :presence => {message: 'Oficial name is required'}
  validates :trading_name, :presence => {message: 'Trading name is required'}  
  has_many :users
  has_many :childs, :foreign_key => "parent_id", :class_name => "Establishment"
  has_many :owned, :foreign_key => "owner_id", :class_name => "Establishment"  
  belongs_to :parent, :autosave => true, :foreign_key => "parent_id", :class_name => "Establishment"
  belongs_to :owner, :autosave => true, :foreign_key => "owner_id", :class_name => "Establishment"
  has_many :addresses, :as => :addressable
  has_many :ibeacons
  
  def as_json(kind)
    case kind
    when "main"
      json_output = { 
                    :name => self.name,
                    :trading_name => self.trading_name
                     }
    when "full"
      json_output = { 
                    :name => self.name,
                    :trading_name => self.trading_name,
                    :gov_identification => self.gov_identification,
                    :description => self.description
                     }
    end
                     
  end
  
end