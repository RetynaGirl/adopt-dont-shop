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

  def update
    if params[:submitted]=='true' && params[:reason] != ""
      Application.find(params[:id]).update(status: "Pending", description: params[:reason])
    end

    if params[:submitted]=='true' && params[:reason] == ""
      flash[:reason] = "A reason for adoption is required before submission"
    end

    if params[:add_pet]
      ApplicationPet.create(application_id: params[:id], pet_id: params[:pet_id])
    end

    redirect_to "/applications/#{params[:id]}"
  end

end
