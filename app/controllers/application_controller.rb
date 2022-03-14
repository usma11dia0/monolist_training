class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  
  private
  
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  
  def read(result)
    code = result['itemCode']
    name = result['itemName']
    url  = result['itemUrl']
    
    if result['mediumImageUrls'].first['imageUrl'].nil?
      image_url = result['mediumImageUrls'].first.gsub('?_ex=128x128', '')
    else
      image_url = result['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '')
    end
    
    {
      code: code,
      name: name,
      url: url,
      image_url: image_url
    }
  end
  
    
  
end
