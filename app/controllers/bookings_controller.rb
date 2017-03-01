class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.create(booking_params)
    redirect_to bookings_path
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    flash[:success] = 'Booking updated!'
    redirect_to bookings_path
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    flash[:success] = 'Booking cancelled!'
    redirect_to bookings_path
  end

  def status
    @status = Booking.status?
  end

  private

  def booking_params
    params.require(:booking).permit(:name, :description, :start_time, :end_time)
  end
end
