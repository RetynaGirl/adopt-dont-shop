class AdminappsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def pet_update
    @app_pet = ApplicationPet.where('pet_id = ? AND application_id = ?', params[:pet_id], params[:app_id]).first
    case params[:todo]
    when 'approve'
      @app_pet.update(status: 'Approved')
      @app_pet.application.update(status: "Approved") if @app_pet.application.approved?
    when 'reject'
      @app_pet.update(status: 'Rejected')
      @app_pet.application.update(status: "Rejected")
    end

    redirect_to("/admin/applications/#{params[:app_id]}")
  end
end
