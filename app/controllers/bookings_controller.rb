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
  # Redirects to the booking show page.
  def update
    respond_to do |format|
      if @booking.update(bookings_params)
        format.html { redirect_to bookings_path(@booking), notice: "Booking was successfully updated." }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_bookings
    @booking = Booking.find(params[:id])
  end

  def bookings_params
    params.require(:bookings).permit(:start_date, :end_date, :confirmed)
  end
end
