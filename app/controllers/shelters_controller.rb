class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new; end

  def create
    shelter = Shelter.create({
                               name: params[:shelter][:name],
                               address: params[:shelter][:address],
                               city: params[:shelter][:city],
                               state: params[:shelter][:city],
                               zip: params[:shelter][:zip]
                             })
  end
end
