class ShelterReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:id])
    @users = User.all
  end

  def create
    @review = Review.create(
      title: params[:review][:title],
      rating: params[:review][:rating],
      content: params[:review][:content],
      user_id: params[:review][:user_id],
      shelter_id: params[:review][:shelter_id],
      image: params[:review][:image]
    )

    redirect_to "/shelters/#{@review.shelter_id}"
  end
end
