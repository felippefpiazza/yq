class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_filter :restrict_access
  
  private
  
  def restrict_access
    (key = ApiKey.where(access_token: request.env["HTTP_TOKEN"], 
                        revoked: false, 
                        device_signature: request.env["HTTP_DEVICE_SIGNATURE"])).present? ? (@user = key.first.user) : (head :unauthorized) 
  end


  def send_response(response)
    respond_to do |format|
      format.json { render json: response }
      format.xml { render xml: response }
    end
  end

  def return_obj(obj_name,id,kind)
    obj = obj_name.downcase.singularize.capitalize.constantize
    if obj.exists?(:id => id)
      send_response(obj.where(:id => id).first.as_json(kind))
    else
      response = {:error => {:response => true, :error_msgs => ["Object not found"]} }
      send_response(response)
    end
  end


end
