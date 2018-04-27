class ContractRevisionsController < ApplicationController
  before_action :set_contract
  before_action :authorize_admin!, only: [:edit, :update]

  def index
    @contract_revisions = @contract.contract_revisions.order(contract_date: :desc)
  end

  def show
    @contract_revision = ContractRevision.find(params[:id])
    @user_loggings = UserLogging.where(contract_revision_id: params[:id])

    if !current_user.nil?
      @contract_user_rating = ContractUserRating.where(contract_revision_id: params[:id], user_id: current_user.id).first
    end
  end

  def new
    @contract_revision = ContractRevision.new
  end

  def create
    @contract_revision = @contract.contract_revisions.build(contract_revision_params)

    saved = false

    ContractRevision.transaction do
      saved = @contract_revision.save

      if saved
        UserLogging.create(:contract_revision_id => @contract_revision.id, :user_id => current_user.id)
      end
    end

    respond_to do |format|
      if saved
        format.html { redirect_to company_contracts_path(@contract.company), :notice => 'Contract was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    @contract_revision = ContractRevision.find(params[:id])
  end

  def update
    @contract_revision = ContractRevision.find(params[:id])

    saved = false

    ContractRevision.transaction do
      saved = @contract_revision.update_attributes(contract_revision_params)

      if saved
        UserLogging.create(:contract_revision_id => @contract_revision.id, :user_id => current_user.id)
      end
    end

    respond_to do |format|
      if saved
        format.html { redirect_to company_contracts_path(@contract.company), :notice => 'Contract was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  private
  def set_contract
    @contract = Contract.find(params[:contract_id])
  end

  def contract_revision_params
    params.require(:contract_revision).permit(
      :contract_id,
      :contract_date,
      :rating_1,
      :rating_2,
      :rating_3,
      :rating_4,
      :rating_5,
      :rating_6,
      :rating_7,
      :rating_8,
      :rating_9,
      :rating_10,
      :rating_14,
      :rating_1_note,
      :rating_2_note,
      :rating_3_note,
      :rating_4_note,
      :rating_5_note,
      :rating_6_note,
      :rating_7_note,
      :rating_8_note,
      :rating_9_note,
      :rating_10_note,
      :additional_note,
      :number_lawsuit,
      :ways_to_improve,
      :lawsuit_note,
      :tos_url
    )
  end
end
