class Api::IbeaconController < ApplicationController
    before_filter :restrict_access , :except => [ ]

  def create_ibeacon

      ibeacon = Ibeacon.new(ibeacon_params)      
      ibeacon.establishment = Establishment.where(:id => params["establishment"]).first    
      if ibeacon.valid?
        ibeacon.save
        response = {:ibeacon => ibeacon.as_json("main"), :error => {:response => false, :error_msgs => []}}
      else
        messages = []
        ibeacon.errors.messages.each do |what,msg|
          messages << msg[0]
        end        
        response = {:error => {:response => true, :error_msgs => messages}}
      end
    send_response(response)
  end
  
  def get_ibeacon
    id = params["id"]
    kind = params["kind"]
    return_obj("Ibeacon",id,kind)
  end
  
  private 
  
  def ibeacon_params
    params.require(:ibeacon).permit(:description,
                                    :mac_address
                                    )
    
  end
end
