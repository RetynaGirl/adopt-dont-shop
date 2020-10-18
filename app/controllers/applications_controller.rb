class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @user = @application.user
    @pets = @application.pets
    if params[:search]
      @search = params[:search]
      @pet_search = Pet.where("lower(name) like ?", "%#{params[:search].downcase}%")
    end
  end

  def add_pet
    ApplicationPet.create(
      application_id: params[:app_id], 
      pet_id: params[:pet_id]
    )
    redirect_to "/applications/#{params[:app_id]}"
  end

  def update
    if params[:submitted]
      Application.find(params[:id]).update(status: "Pending")
    end

    redirect_to "/applications/#{params[:id]}"
  end

end
