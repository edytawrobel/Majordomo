class BookingsController < ApplicationController

  def index
    @room = Room.find(params[:room_id])
    @bookings = @room.bookings
  end

  def new
    @room = Room.find(params[:room_id])
    @booking = Booking.new
  end

  def create
    @room = Room.find(params[:room_id])
    @booking = @room.bookings.new(booking_params)
    if @booking.save
      flash[:success] = 'Booked!'
      redirect_to room_path(@room)
    else
      flash[:alert] = "This booking overlaps others"
      redirect_to new_room_booking_path(@room)
    end
  end

  def show
    @room = Room.find(params[:room_id])
    @booking = Booking.find(params[:id])
  end

  def edit
    @room = Room.find(params[:room_id])
    @booking = Booking.find(params[:id])
  end

  def update
    @room = Room.find(params[:room_id])
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)
    flash[:success] = 'Booking updated!'
    redirect_to room_path(@room)
  end

  def destroy
    @room = Room.find(params[:room_id])
    @booking = Booking.find(params[:id])
    @booking.destroy
    flash[:success] = 'Booking cancelled!'
    redirect_to room_path(@room)
  end

  def status
    @status = Booking.status?(params[:room_id])
  end

  private

  def booking_params
    params.require(:booking).permit(:name, :description, :start_time, :end_time, :room_id)
  end

  # def no_overlapping_bookings
  #   overlaps = @room.bookings.where('start_time <= ? AND end_time >= ?', end_time, start_time)
  #   return if overlaps.empty?
  #   return if overlaps.count == 1 && overlaps.first.id == id
  #   errors.add(:start_time, "This booking overlaps others")
  # end
end
