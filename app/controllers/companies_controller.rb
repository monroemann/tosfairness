require 'pry'
class CompaniesController < ApplicationController
    before_action :authorize_admin!, only: [:edit, :update]
    before_action :set_company, only: [:edit, :update]
    autocomplete :company, :company_name, :full => true

    def index
      @companies = Company.all

      if params[:search]
        @companies = Company.name_like("%#{params[:search]}%")
      end

      ids = @companies.pluck(:id)
      @companies = Company.with_contract_review_status(ids)

      @company = Company.new
    end

    def show
    end

    def new
      @company = Company.new
    end

    def create
      if company_params[:tos_flag] == 'new'
        @company = Company.new(company_params)
        if @company.save
          redirect_to root_path, notice: 'Company was successfully created and added to a waitlist.'
        else
          render :new
        end
      else
        @company = Company.find_by(company_name: company_params[:company_name])

        if @company.present?
          @update_request = UpdateRequest.new
          @update_request.company_id = @company.id
          @update_request.request_note = company_params[:request_note]
          @update_request.status = "Requested"

          if @update_request.save
            redirect_to root_path, notice: 'A contract update request was successfully created and added to a waitlist.'
          else
            @company = Company.new
            flash.now[:error] = "Error in creating an update request, please contact administrator"
            render :new
          end
        else
          @company = Company.new
          flash.now[:error] = "This company is currently not existing in the system."
          render :new
        end
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
        :website,
        :tos_flag,
        :request_note)
    end

    def set_company
      @company = Company.find(params[:id])
    end
end
