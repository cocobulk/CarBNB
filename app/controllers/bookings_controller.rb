class BookingsController < ApplicationController

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
    @booking = Booking.find(params[:id])
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
  end

  private

  def set_bookings
    @booking = Booking.find(params[:id])
  end

  def bookings_params
    params.require(:bookings).permit(:start_date, :end_date, :confirmed)
  end
end
