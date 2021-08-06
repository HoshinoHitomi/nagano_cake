class Public::HomesController < ApplicationController

  def top
    @genres = Genre.all
    @items = Item.first(4)
  end

  def about
  end
end
