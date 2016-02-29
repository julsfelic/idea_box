class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "#{@category.name} was created!"
      redirect_to admin_categories_path
    else
      flash[:error] = @category.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
