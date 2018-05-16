class CompaniesController < ApplicationController
    autocomplete :company, :company_name, :full => true

    def index
      @companies = Company.all

      if params[:search]
        @companies = Company.name_like("%#{params[:search]}%")
      end

      @companies = @companies.
                      select("companies.*, COUNT(contracts.id) AS contract_count").
                      left_outer_joins(:contracts).group("companies.id").
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
end
