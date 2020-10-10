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
end
