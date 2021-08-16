class Admin::SearchesController < ApplicationController
  def search
    @value = params["search"]["value"]
    @datas = search_for(@value)
  end

  private

  def search_for(value)
    Customer.where(["last_name LIKE ? OR first_name LIKE ?", "%#{value}%", "%#{value}%"]).page(params[:page]).per(10)
  end

end