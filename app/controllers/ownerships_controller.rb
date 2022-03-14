class OwnershipsController < ApplicationController
  def create
    @item = Item.find_or_initialize_by(code: params[:item_code])
    
    unless @item.persisted?
      #@itemが保存されていない場合、先に@itemを保存する
      results = RakutenWebService::Ichiba::Item.search(itemCode: @item.code)
      
      @item = Item.new(read(results.first))
      @item.save
    end
    
    #want関係として保存
    if params[:type] == 'Want'
      current_user.want(@item)
      flash[:success] = '商品をWantしました。'
    end
  
    #had関係として保存
    if params[:type] == 'Had'
      current_user.had(@item)
      flash[:success] = '商品をHadしました。'
    end
    redirect_back(fallback_location: root_path)
  end
  



  def destroy
    @item = Item.find(params[:item_id])
    
    if params[:type] == 'Want'
      current_user.unwant(@item)
      flash[:success] = '商品のWantを解除しました。'
    end
    
    if params[:type] == 'Had'
      current_user.not_had(@item)
      flash[:success] = '商品のHadを解除しました'
    end
    redirect_back(fallback_location: root_path)
  end
end
