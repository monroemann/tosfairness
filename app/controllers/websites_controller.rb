class WebsitesController < ApplicationController
  def index
    @top_ten_fairs = Contract.top_ten
    @top_ten_unfairs = Contract.last_ten
  end

  def top_ten_fair
    @top_ten_fairs = Contract.top_ten
  end

  def top_ten_unfair
    @top_ten_unfairs = Contract.last_ten
  end
end
