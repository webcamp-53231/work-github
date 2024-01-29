class HomesController < ApplicationController
  def top
  @orders = Order.all
  @items = Item.all
  end

  def about
  end
end
