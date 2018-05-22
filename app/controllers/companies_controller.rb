class CompaniesController < ApplicationController
    before_action :authorize_admin!, only: [:edit, :update]
    before_action :set_company, only: [:edit, :update]
    autocomplete :company, :company_name, :full => true

    def index
      @companies = Company.all

      if params[:search]
        @companies = Company.name_like("%#{params[:search]}%")
      end

      @companies = @companies.
                    left_outer_joins(:contracts).
                    left_outer_joins(:contract_revisions).
                    select("companies.*").
                    select("SUM(case when contract_revisions.status = 'Completed' then 1
                         else 0 end) AS contract_count").
                    group("companies.id").
                    order("companies.company_name")

      @company = Company.new
    end

    def show
    end

    def new
      @company = Company.new
    end

    def create
      @company = Company.new(company_params)

      if @company.save
        redirect_to root_path, notice: 'Company was successfully created and added to a waitlist.'
      else
        render :new
      end
    end

    def edit
    end

    def update
     if @company.update_attributes(company_params)
       redirect_to company_contracts_path(@company), :notice => 'Company was successfully updated.'
     else
       render :edit
     end
   end

    def autocomplete_company_company_name
      term = params[:term]
      query = "%#{term}%"

      companies = Company.name_like(query).order('company_name').all

      render :json => companies.map { |company| {:id => company.id, :label => company.company_name, :value => company.company_name }}
    end

    private
    def company_params
      params.require(:company).permit(
        :company_name,
        :website)
    end

    def set_company
      @company = Company.find(params[:id])
    end
end
