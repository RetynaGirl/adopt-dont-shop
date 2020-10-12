class SheltersController < ApplicationController
  def index
    # require 'pry'; binding.pry
    shelters = Shelter.all
    case params[:sort]
    when 'alph'
      @shelters = shelters.sort_by { |shelter| shelter.name.capitalize }
    when 'pets'
      @shelters = shelters.sort_by { |shelter| shelter.pets.count }.reverse
    else
      @shelters = shelters
    end
    # require 'pry'; binding.pry

  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new; end

  def create
    Shelter.create({
                     name: params[:shelter][:name],
                     address: params[:shelter][:address],
                     city: params[:shelter][:city],
                     state: params[:shelter][:state],
                     zip: params[:shelter][:zip]
                   })
    redirect_to '/shelters'
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])

    # shelter.name = params[:shelter][:name]
    # shelter.address = params[:shelter][:address]
    # shelter.city = params[:shelter][:city]
    # shelter.state = params[:shelter][:state]
    # shelter.zip = params[:shelter][:zip]

    shelter.update({
                     name: params[:shelter][:name],
                     address: params[:shelter][:address],
                     city: params[:shelter][:city],
                     state: params[:shelter][:state],
                     zip: params[:shelter][:zip]
                   })

    # shelter.save

    redirect_to "/shelters/#{shelter.id}"
  end

  def delete
    Shelter.find(params[:id]).delete

    redirect_to '/shelters'
  end

  def pets
    @shelter = Shelter.find(params[:id])
    @pets = @shelter.pets.partition{ |pet| pet.adoptable }.flatten
    if params[:filter] == 'adoptable'
      @pets = @pets.select(&:adoptable)
    elsif params[:filter] == 'pending'
      @pets = @pets.reject(&:adoptable)
    end
  end

  def new_pet
    @shelter = Shelter.find(params[:id])
  end
end
