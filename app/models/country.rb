class Country < ActiveRecord::Base
  has_many :addresses
  def as_json()
    case kind
    when "main"
      json_output = { :id => self.id,  
                    :name => self.name
                   }
    end
  end  
  
end
