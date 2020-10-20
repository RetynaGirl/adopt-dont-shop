class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])

    if params[:search]
      @search = params[:search]
      # pets_on_app = @application.pets.pluck(:pet_id)
      # @pet_search = Pet.where("lower(name) like ? ", "%#{params[:search].downcase}%")
      @pet_search = Pet.where("pets.id NOT IN (SELECT pet_intersect.id
                                               FROM pets, application_pets
                                               JOIN pets AS pet_intersect ON pet_intersect.id = application_pets.pet_id
                                               WHERE application_pets.application_id = #{@application.id}
                                               GROUP BY pet_intersect.id)")
                       .where('lower(name) like ? ', "%#{params[:search].downcase}%")

    end
  end

  def update
    if params[:submitted] == 'true' && params[:reason] != ''
      Application.find(params[:id]).update(status: 'Pending', description: params[:reason])
    end

    if params[:submitted] == 'true' && params[:reason] == ''
      flash[:reason] = 'A reason for adoption is required before submission'
    end

    ApplicationPet.create(application_id: params[:id], pet_id: params[:pet_id]) if params[:add_pet]

    redirect_to "/applications/#{params[:id]}"
  end

  def new
    @users = User.all
  end

  def create
    @application = User.find(params[:application][:user]).applications.create(status: 'In Progress')

    redirect_to "/applications/#{@application.id}"
  end
end
