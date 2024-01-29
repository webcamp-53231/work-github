class Public::CartItemsController < ApplicationController
before_action :authenticate_customer!

def index
  @cart_items = current_customer.cart_items
  @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.line_total }
end

def create

  existing_cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id] )
  if existing_cart_item
  existing_cart_item.amount+=params[:cart_item][:amount].to_i
  existing_cart_item.save
  else
  cart_item = current_customer.cart_items.new(cart_item_params)
  cart_item.save
  end  
   flash[:notice] = "・商品をカートに追加しました"
  redirect_to cart_items_path
end
  
def update
  @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
  @cart_item.update(cart_item_params) if @cart_item
  
  #@cart_item = CartItems.find_by(item_id: params[:cart_item][:item_id] )
  
  flash[:notice] = "・数量を変更しました"
  redirect_to cart_items_path
end

def destroy_all
  current_customer.cart_items.destroy_all
  flash[:notice] = "・カート内すべての商品を削除しました"
  redirect_to cart_items_path
end

def destroy
  @cart_item = current_customer.cart_items.find(params[:id])
  @cart_item.destroy
  flash[:notice] = "・選択した商品を削除しました"
  redirect_to cart_items_path
end



private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end


end
