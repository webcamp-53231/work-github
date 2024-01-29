class Public::OrdersController < ApplicationController
before_action :authenticate_customer!

  def new
  @order = Order.new
  end
  
  def confirm
  @order = Order.new(order_params)
    if params[:order][:payment_method].blank?
        flash[:notice] = "お支払い方法が選択されていません"
       render :new
       return
    end  
    
    if params[:order][:select_address] == "0"
       @order.postal_code = current_customer.postal_code
       @order.address = current_customer.address
       @order.name = current_customer.last_name + current_customer.first_name
    
    elsif params[:order][:select_address] == "1"
       if params[:order][:postal_code].blank? 
           flash[:notice] = "新しいお届け先に空欄があります"
          render :new
          return
       end   
       if params[:order][:address].blank? 
          flash[:notice] = "新しいお届け先に空欄があります"
         render :new
         return
       end 
       if params[:order][:name].blank? 
         flash[:notice] = "新しいお届け先に空欄があります"
         render :new
         return
       end
      @order.postal_code = params[:order][:postal_code] 
      @order.address = params[:order][:address] 
      @order.name = params[:order][:name]
    
    else
       flash[:notice] = "お届け先が選択されていません"
      render :new
      return
    end
   
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.line_total }   
    @order.total_payment = @order.shipping_cost + @total
  
  end

   def create
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    @order.save
    @cart_items.each do |cart|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart.item_id
      @order_detail.amount = cart.amount
      @order_detail.price = cart.item.price
      @order_detail.save
    end
    
    @cart_items.destroy_all
    redirect_to orders_complete_path
    
   end
  
  def complete
  end
  
  def index
  @orders = current_customer.orders
  end
  
  def show
  @order = current_customer.orders.find(params[:id])
  
  end

def order_params
  params.require(:order).permit(:name, :address, :price, :postal_code, :shipping_cost, :total_payment, :payment_method )
end

end
