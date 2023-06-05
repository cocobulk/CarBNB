class CarsController < ApplicationController

  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
  end

  def new
    @car = Car.new
    # you need to give an empty shell to your form_with!
  end

  def create
    @car = Car.new(cars_params)
    if @car.save
      redirect_to cars_path(@cars)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @car = Car.find(params[:id])
  end

  def update
    @car = Car.find(params[:id])
    if @car.update(cars_params)
      redirect_to cars_path(cars)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    redirect_to carss_path, status: :see_other
  end

private

  def set_cars
    @car = Car.find(params[:id])
  end

  def cars_params
    params.require(:cars).permit(:model, :year, :seats_number, :price, :availability)
  end
end
