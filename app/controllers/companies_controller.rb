class CompaniesController < ApplicationController
    autocomplete :company, :company_name, :full => true
    validates :company_name, presence: true
    validates :website, presence: true


    def index
      @companies = Company.order('company_name')
      if params[:search]
        @companies = Company.name_like("%#{params[:search]}%").order('company_name')
      end

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
