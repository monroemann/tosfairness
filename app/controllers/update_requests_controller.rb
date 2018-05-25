class UpdateRequestsController < ApplicationController
  before_action :authorize_admin!

  def index
    @update_requests = UpdateRequest.all
  end

  def edit
    @update_request = UpdateRequest.find(params[:id])
  end

  def update
    @update_request = UpdateRequest.find(params[:id])

   if @update_request.update_attributes(update_request_params)
     redirect_to update_requests_path, :notice => 'Update Request was successfully updated.'
   else
     render :edit
   end
  end

  private

  def update_request_params
    params.require(:update_request).permit(
      :request_note,
      :status
    )
  end
end
