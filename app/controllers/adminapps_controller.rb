class AdminappsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def pet_update
    @app_pet = ApplicationPet.where('pet_id = ? AND application_id = ?', params[:pet_id], params[:app_id]).first

    case params[:todo]
    when 'approve'
      @app_pet.status = 'Approved'
    when 'reject'
      @app_pet.status = 'Rejected'
    end

    @app_pet.save

    redirect_to("/admin/applications/#{params[:app_id]}")
  end
end
