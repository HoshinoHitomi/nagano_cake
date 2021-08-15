class Public::SearchesController < ApplicationController
  def search
    @genres = Genre.all

    @value = params["search"]["value"]
    @how = params["search"]["how"]
    @datas = search_for(@how, @value)
  end

  private

  def match(value)
    Item.where(name: value).or(Item.where(genre_id: value)).page(params[:page]).per(8)
  end

  def partical(value)
    Item.where("name LIKE ?", "%#{value}%").page(params[:page]).per(8)
  end

  def search_for(how, value)
    case how

    when 'match'
      match(value)
    when 'partical'
      partical(value)
    end
  end

end
