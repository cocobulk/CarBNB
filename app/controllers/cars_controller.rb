class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    #@cars = Car.all
    @cars = policy_scope(Car)
  end

  def show
    @car = Car.find(params[:id])
    authorize @car
    # authorize @car # @dev Pundit >> models/policy/car_policy.rb
  end

  def showmycar
    @car = Car.find(params[:id])
    authorize @car
  end

  def new
    @car = Car.new
    # you need to give an empty shell to your form_with!
    authorize @car # @dev Pundit >> models/policy/car_policy.rb
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user
    authorize @car # @dev Pundit >> models/policy/car_policy.rb
    if @car.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @car = Car.find(params[:id])
    authorize @car
  end

  def update
    @car = Car.find(params[:id])

    @car = Car.find(params[:id])
    authorize @car
    if @car.update(car_params)
      redirect_to show_my_car_path(@car)
    else
      render :edit, status: :unprocessable_entity
    end
  end



  def destroy
    @car = Car.find(params[:id])
    authorize @car # @dev Pundit >> models/policy/car_policy.rb
    @car.destroy
    redirect_to cars_path, status: :see_other
  end

  private

  def set_cars
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:model, :year, :seats_number, :price, :availability, photos: [])
  end
end
