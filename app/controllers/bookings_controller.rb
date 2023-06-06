class BookingsController < ApplicationController
  before_action :set_bookings, only: %i[ show edit update destroy ]

  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
    # you need to give an empty shell to your form_with!
  end

  def create
    @booking = Booking.new(bookings_params)
    if @booking.save
      redirect_to bookings_path(@bookings)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # placeholder for reference as to where view gets instance var.
    # @booking = Booking.find(params[:id])
  end

  # PATCH/PUT /booking/:id
  # Redirects to the booking show page. bookings_url(@booking)
  def update
    respond_to do |format|
      if @booking.update(bookings_params)
        redirect_to @booking, notice: "Booking was successfully updated."
        format.json { render :show, status: :ok, location: @booking }
      else
        render :edit, status: :unprocessable_entity
        format.json { render json: @booking.errors, status: :unprocessable_entity, alert: "Booking was not updated." }
      end
    end
  end

  private

  def set_bookings
    @booking = Booking.find(params[:id])
  end

  def bookings_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
