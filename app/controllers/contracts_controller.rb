class ContractsController < ApplicationController
  before_action :set_company
  before_action :authorize_admin!, only: [:edit, :update]

  def index
    @contracts = @company.contracts
  end

  def show
    @contract = Contract.find(params[:id])
  end

  def new
    @contract = Contract.new
  end

  def create
    @contract = @company.contracts.build(contract_params)
    @contract.user = current_user

    if @contract.save
      redirect_to company_contracts_path(@company), notice: 'Contract was successfully created.'
    else
      render :new
    end
  end

  def edit
    @contract = Contract.find(params[:id])
  end

  def update
    @contract = Contract.find(params[:id])
    @contract.user = current_user

    if @contract.update_attributes(contract_params)
      redirect_to company_contracts_path(@company), notice: 'Contract was successfully updated.'
    else
      render :edit
    end
  end

  private
  def set_company
    @company = Company.find(params[:company_id])
  end

  def contract_params
    params.require(:contract).permit(
      :contract_title,
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
      :rating_11,
      :rating_12,
      :rating_13,
      :rating_14,
      :rating_15
    )
  end
end
