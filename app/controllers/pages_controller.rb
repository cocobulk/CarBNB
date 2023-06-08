class PagesController < ApplicationController
  def home
  end

  def dashboard
    @bookings = current_user.bookings
    @received_bookings = current_user.cars.map do |car|
      car.bookings
    end.flatten
    @cars = current_user.cars
  end

  def show_account
    @user = current_user
  end
end
