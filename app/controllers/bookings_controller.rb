class BookingsController < ApplicationController
  before_action :set_bookings, only: %i[ show edit update destroy ]

  def index
    @bookings = Booking.all
    @bookings = policy_scope(Booking)
    #authorize @bookings
  end

  def show
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def new
    @booking = Booking.new
    @car = Car.find(params[:car_id])
    authorize @booking
  end

  def create
    @booking = Booking.new(bookings_params)
    @car = Car.find(params[:car_id])
    @booking.car = @car
    @booking.user = current_user
    @car.availability = false
    authorize @booking
    if @booking.save
      redirect_to bookings_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # placeholder for reference as to where view gets instance var.
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  # PATCH/PUT /booking/:id
  # Redirects to the booking show page. bookings_url(@booking)
  def update
    # respond_to do |format|
    if @booking.update(bookings_params)
      redirect_to bookings_url(@booking), notice: "Booking was successfully updated."
      # format.html { redirect_to @booking, notice: "Booking was successfully updated." }
      # format.json { render :show, status: :ok, location: @booking }
    else
      render :edit, status: :unprocessable_entity
      # format.html { render :edit, status: :unprocessable_entity }
      # format.json { render json: @booking.errors, status: :unprocessable_entity, alert: "Booking was not updated." }
    end
    # end
    authorize @booking
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
    authorize @booking
  end

  def approve
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.update(confirmed: true)
    redirect_to dashboard_path
  end

  private

  def set_bookings
    @booking = Booking.find(params[:id])
  end

  def bookings_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
