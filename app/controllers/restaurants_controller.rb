class RestaurantsController < ApplicationController

  before_action :find_by_params, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    @restaurant.user_id = current_user.id
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @restaurant.user == current_user
      @restaurant.update(restaurant_params)
      redirect_to '/restaurants'
    end
  end

  def destroy
    if @restaurant.user == current_user
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
      redirect_to '/restaurants'
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description)
  end

  def find_by_params
    @restaurant = Restaurant.find(params[:id])
  end

end
