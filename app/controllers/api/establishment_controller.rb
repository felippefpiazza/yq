class Api::EstablishmentController < ApplicationController
    before_filter :restrict_access , :except => []
  
  def create_establishment
    if params["parent_establishment"].present? and Establishment.exists?(:id => params["parent_establishment"])
      top = Establishment.new(establishment_params)      
      top.parent = Establishment.where(:id => params["parent_establishment"]).first
      e = top
      if params["owner_establishment"].present? and Establishment.exists?(:id => params["owner_establishment"])    
        top.owner = Establishment.where(:id => params["owner_establishment"]).first
      else
        top.owner = top.parent
      end
    else
      top = @user
      top.establishment = Establishment.new(establishment_params)      
      e = top.establishment
      #
      #binding.pry
    end

    
      if top.valid?
        top.save
        response = {:establishment => e.as_json("main"), :error => {:response => false, :error_msgs => []}}
      else
        messages = []
        top.errors.messages.each do |what,msg|
          messages << msg[0]
        end        
        #binding.pry
        response = {:error => {:response => true, :error_msgs => messages}}
      end
    send_response(response)
  end

  def get_establishment
    id = params["id"]
    kind = params["kind"]
    return_obj("Establishment",id,kind)
  end
    
  private 
  
  def establishment_params
    params.require(:establishment).permit(:name,
                                    :trading_name,
                                    :gov_identification,
                                    :description
                                    )
    
  end
  
end
