class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    initial_cars = params[:location].present? ? Car.near(params[:location]) : Car.all
    @cars = policy_scope(initial_cars)
    @cars = @cars.where('price >= ?', params[:price].split('-').first) if params[:price].present?
    @markers = @cars.geocoded.map do |car|
      {
        lat: car.latitude,
        lng: car.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {car: car}),
        marker_html: render_to_string(partial: "marker", locals: {car: car}) # Pass the car to the partial
      }
    end


    if params[:query].present?
      @cars = Car.where("model ILIKE ?", "%#{params[:query]}%")
    end
    if params[:seats_number].present?
      @cars = Car.where(seats_number: params[:seats_number])
      @cars = Car.where("seats_number > 5") if params[:seats_number] == "6+"
    end
    if params[:price].present?
      @cars = Car.where("price < ?", params[:price])
    end
  end

  def show
    @car = Car.find(params[:id])
    @review = Review.new
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


      if @car.update(car_params) && @car.photos.attached?
        redirect_to dashboard_path
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
    params.require(:car).permit(:model, :address, :year, :seats_number, :price, :availability, photos: [])
  end
end
