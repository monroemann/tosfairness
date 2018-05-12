class WebsitesController < ApplicationController
  def index
    @top_ten_fairs = ContractRevision.top_ten
    @top_ten_unfairs = ContractRevision.last_ten
    @latest_reviews = ContractRevision.recent_review
  end

  def top_ten_fair
    @top_ten_fairs = ContractRevision.top_ten
  end

  def top_ten_unfair
    @top_ten_unfairs = ContractRevision.last_ten
  end

  def latest_reviews
    @latest_reviews = ContractRevision.recent_review
  end
end
