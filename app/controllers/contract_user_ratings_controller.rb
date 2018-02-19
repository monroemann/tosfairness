class ContractUserRatingsController < ApplicationController
  before_action :authenticate_user
  before_action :load_contract, only: %i(create)
  before_action :load_user, only: %i(create)

  def create
    @contract_user_rating = ContractUserRating.find_or_initialize_by(create_params)
    @contract_user_rating.rating = contract_user_rating_params[:rating]

    flash[:success] = 'User Rating added' if @contract_user_rating.save!
    handle_redirect
  end

  private

  def load_contract_user_rating
    @contract_user_rating = ContractUserRating.find(params[:id])
  end

  def load_contract
    @contract = Contract.find(contract_user_rating_params[:contract_id])
  end

  def load_user
    @user = User.find(contract_user_rating_params[:user_id])
  end

  def create_params
    { contract: @contract, user: @user }
  end

  def contract_user_rating_params
    params
      .require(:contract_user_rating)
      .permit(:contract_id,
              :user_id,
              :rating)
  end
end
