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
    @contract = @company.contracts.new
  end

  def create
    @contract = @company.contracts.new(contract_params)

    if @contract.save
      redirect_to company_contracts_path(@company), :notice => 'Contract was successfully created.'
    else
      render :new
    end
  end

  def edit
    @contract = Contract.find(params[:id])
  end

  def update
    @contract = Contract.find(params[:id])

   if @contract.update_attributes(contract_params)
     redirect_to company_contracts_path(@company), :notice => 'Contract was successfully updated.'
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
      :company_id,
      :contract_title,
      :website,
      :application,
      :contract_type
    )
  end
end
