class IdeasController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_params)

    if @idea.save
      redirect_to idea_path(@idea)
    end
  end

  def show
    @idea = Idea.find(params[:id])
  end

  private

  def idea_params
    params.require(:idea).permit(:description).merge(user_id: params[:user_id])
  end
end
