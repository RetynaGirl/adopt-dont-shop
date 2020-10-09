class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
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
end
