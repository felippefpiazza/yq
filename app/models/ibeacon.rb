class Ibeacon < ActiveRecord::Base
  validates :establishment, :presence => {message: 'A valid establishment is required'}
  validates_uniqueness_of :mac_address , :message => 'Mac address already in use'
  
  has_many :addresses, :as => :addressable
  belongs_to :establishment
  
  def as_json(kind)
    case kind
    when "main"
      json_output = { 
                    :description => self.description,
                    :mac_address => self.mac_address
                     }
    when "full"
      json_output = { 
                    :description => self.description,
                    :mac_address => self.mac_address,
                    :address => self.addresses.first.as_json("full")
                     }
    end
                     
  end
  
end
