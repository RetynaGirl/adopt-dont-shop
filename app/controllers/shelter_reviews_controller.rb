class ShelterReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:id])
    @users = User.all
  end

  def create
    @review = Review.new(
      title: params[:review][:title],
      rating: params[:review][:rating],
      content: params[:review][:content],
      user_id: params[:review][:user_id],
      shelter_id: params[:review][:shelter_id],
      image: params[:review][:image]
    )
    if @review.save

      redirect_to "/shelters/#{@review.shelter_id}"
    else

      flash[:error] = 'Please enter data in all required (*) fields'
      redirect_to "/shelters/#{params[:review][:shelter_id]}/reviews/new"
    end
  end

  def edit
    @review = Review.find(params[:id])
    @users = User.all
  end

  def update
    @review = Review.find(params[:id])
    @review.update(
      title: params[:review][:title],
      rating: params[:review][:rating],
      content: params[:review][:content],
      user_id: params[:review][:user_id],
      shelter_id: params[:review][:shelter_id],
      image: params[:review][:image]
    )

    redirect_to "/shelters/#{@review.shelter_id}"
  end

  def delete
    review = Review.find(params[:id])
    shelter_id = review.shelter_id
    review.delete
    redirect_to "/shelters/#{shelter_id}"
  end
end
