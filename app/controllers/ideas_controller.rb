class IdeasController < ApplicationController
  before_action :find_user, only: [:index, :new]
  before_action :redirect_if_not_correct_user, only: [:index]

  def index
    @ideas = @user.ideas
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_params)
    @user = @idea.user

    if @idea.save
      redirect_to idea_path(@idea)
    else
      flash.now[:error] = "Idea must have a name"
      render :new
    end
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def update
    @idea = Idea.find(params[:id])

    if @idea.update(idea_params)
      flash[:success] = "Idea successfully updated!"
      redirect_to @idea
    else
      flash.now[:error] = "Name cannot be blank."
      render :edit
    end
  end

  def destroy
    @idea = Idea.find(params[:id]).destroy
    flash[:notice] = "#{@idea.name} has been deleted."
    redirect_to user_ideas_path(current_user)
  end

  private

  def idea_params
    params.require(:idea).permit(:name, :description).
           merge(user_id: params[:user_id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end
end
