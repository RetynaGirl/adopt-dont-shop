class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
    @adoptability = if @pet.adoptable
                      'Yes'
                    else
                      'No'
                    end
    @shelter = @pet.shelter
  end

  def new
    @pet = Pet.create(
      name: params[:pet][:name],
      image: params[:pet][:image],
      age: params[:pet][:age],
      sex: params[:pet][:sex],
      shelter_id: params[:pet][:shelter_id],
      description: params[:pet][:description],
      adoptable: params[:pet][:adoptable]
    )

    redirect_to "/shelters/#{@pet.shelter_id}/pets"
  end
end
