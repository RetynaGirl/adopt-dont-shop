class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new

  end

  def create
    @user = User.create({
                     name: params[:user][:name].titleize,
                     address: params[:user][:address],
                     city: params[:user][:city],
                     state: params[:user][:state],
                     zip: params[:user][:zip]
                   })
    redirect_to "/users/#{@user.id}"
  end
end
