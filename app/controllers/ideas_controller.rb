class IdeasController < ApplicationController
  before_action :find_user, except: :destroy
  before_action :redirect_if_not_correct_user, only: [:index, :show, :new]
  before_action :find_idea, only: [:show, :edit, :update, :destroy]

  def index
    @ideas = @user.ideas
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_params)

    if @idea.save
      redirect_to user_idea_path(@user, @idea)
    else
      flash.now[:error] = "Idea must have a name"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @idea.update(idea_params)
      flash[:success] = "Idea successfully updated!"
      redirect_to user_idea_path(@user, @idea)
    else
      flash.now[:error] = "Name cannot be blank."
      render :edit
    end
  end

  def destroy
    @idea.destroy
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

  def find_idea
    @idea = Idea.find(params[:id])
  end
end
