class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @user = @application.user
    @pets = @application.pets
  end
end
