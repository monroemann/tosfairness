class ContractsController < ApplicationController
  before_action :set_company
  before_action :authorize_admin!, only: [:edit, :update]

  def index
    @contracts = @company.contracts.order(contract_date: :desc)
  end

  def show
    @contract = Contract.find(params[:id])
    @user_loggings = UserLogging.where(contract_id: params[:id])

    if !current_user.nil?
      @contract_user_rating = ContractUserRating.where(contract_id: params[:id], user_id: current_user.id).first
    end
  end

  def new
    @contract = Contract.new
  end

  def create
    @contract = @company.contracts.build(contract_params)

    saved = false

    Contract.transaction do
      saved = @contract.save

      if saved
        UserLogging.create(:contract_id => @contract.id, :user_id => current_user.id)
      end
    end

    respond_to do |format|
      if saved
        format.html { redirect_to company_contracts_path(@company), :notice => 'Contract was successfully created.' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    @contract = Contract.find(params[:id])
  end

  def update
    @contract = Contract.find(params[:id])

    saved = false

    Contract.transaction do
      saved = @contract.update_attributes(contract_params)

      if saved
        UserLogging.create(:contract_id => @contract.id, :user_id => current_user.id)
      end
    end

    respond_to do |format|
      if saved
        format.html { redirect_to company_contracts_path(@company), :notice => 'Contract was successfully updated.' }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  private
  def set_company
    @company = Company.find(params[:company_id])
  end

  def contract_params
    params.require(:contract).permit(
      :company_id,
      :contract_title,
      :website,
      :application,
      :contract_date,
      :contract_type,
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
      :number_lawsuit
    )
  end
end
