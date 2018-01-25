class ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :edit, :update]
  before_action :authorize_admin!, only: [:edit, :update]
  autocomplete :contract, :company_name, :full => true

  def index
    @contracts = Contract.order('company_name')
    if params[:search]
      @contracts = Contract.name_like("%#{params[:search]}%").order('company_name')
    end

    @contract = Contract.new
  end

  def show

  end

  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)

    if @contract.save
      redirect_to root_path, notice: 'Company was successfully created and added to a waitlist.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @contract.user = current_user

    if @contract.update_attributes(contract_params)
      redirect_to contracts_path, notice: 'Contract was successfully updated.'
    else
      render :edit
    end
  end

  def autocomplete_contract_company_name
    term = params[:term]
    query = "%#{term}%"

    contracts = Contract.name_like(query).order('company_name').all

    render :json => contracts.map { |contract| {:id => contract.id, :label => contract.company_name, :value => contract.company_name }}
  end

  private
  def set_contract
    @contract = Contract.find(params[:id])
  end

  def contract_params
    params.require(:contract).permit(
      :company_name,
      :website,
      :contract_title,
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
      :rating_10
    )
  end
end
