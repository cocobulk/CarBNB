class PagesController < ApplicationController
  def home
  end

  def dashboard
    @bookings = current_user.bookings
    @cars = current_user.cars
  end
end
