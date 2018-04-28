class ContractUserRatingsController < ApplicationController
  before_action :authenticate_user
  before_action :load_contract_revision, only: %i(create)
  before_action :load_user, only: %i(create)
  before_action :load_contract_user_rating, only: %i(show edit update)

  def create
    @contract_user_rating = ContractUserRating.find_or_initialize_by(create_params)
    @contract_user_rating.rating = contract_user_rating_params[:rating]
    @contract_user_rating.comment = contract_user_rating_params[:comment]

    flash[:success] = 'User Review added' if @contract_user_rating.save!
    handle_redirect
  end

  def edit

  end

  def update
    if @contract_user_rating.update_attributes(contract_user_rating_params)

      flash[:success] = 'User Review Updated'
      redirect_to contract_contract_revision_path(@contract_user_rating.contract_revision.contract, @contract_user_rating.contract_revision)
    else
      load_contract_user_rating
      render 'edit'
    end
  end

  private

  def load_contract_user_rating
    @contract_user_rating = ContractUserRating.find(params[:id])
  end

  def load_contract_revision
    @contract_revision = ContractRevision.find(contract_user_rating_params[:contract_revision_id])
  end

  def load_user
    @user = User.find(contract_user_rating_params[:user_id])
  end

  def create_params
    { contract_revision: @contract_revision, user: @user }
  end

  def contract_user_rating_params
    params
      .require(:contract_user_rating)
      .permit(:contract_revision_id,
              :user_id,
              :rating,
              :comment)
  end
end
