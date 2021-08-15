class Public::ItemsController < ApplicationController
  before_action :authenticate!, except: [:index]

  def index
    @items = Item.all.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def authenticate!
    if admin_signed_in?

    else
    	authenticate_customer!
    end
  end
end
