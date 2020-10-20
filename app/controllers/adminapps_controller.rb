class AdminappsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def pet_update
    @app_pet = ApplicationPet.where('pet_id = ? AND application_id = ?', params[:pet_id], params[:app_id]).first
    @application = Application.find(params[:app_id])
    case params[:todo]
    when 'approve'
      @app_pet.update(status: 'Approved')
      @application.update(status: "Approved") if @application.all_pets_approved
    when 'reject'
      @app_pet.update(status: 'Rejected')
      @application.update(status: "Rejected")
    end

    redirect_to("/admin/applications/#{params[:app_id]}")
  end
end
