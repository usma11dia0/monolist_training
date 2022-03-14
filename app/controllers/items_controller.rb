class ItemsController < ApplicationController
  before_action :require_user_logged_in 
  
  def new
    @items = []
    
    @keyword = params[:keyword]
    if @keyword.present?
      results = RakutenWebService::Ichiba::Item.serch({
        keyword:@keyword,
        imageFlag: 1,
        hits: 20,
      })
    end
    
    results.each do |result|
      item = Item.new(read(result))
      @items << item
    end
  end

　private
　
　def read(result)
　  code = result['itemCode']
　  name = result['itemName']
　  url  = result['itemUrl']
　  image_url = result['mediumImageUrls'].first['imageUrl'].gsub('?_ex=128x128', '')
　  
　  {
　    code: code
　    name: name
　    url: url
　    iamge_url: image_url
　  }
　end 
end 