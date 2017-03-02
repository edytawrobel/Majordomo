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
    @room.bookings.create(booking_params)
    redirect_to room_path(@room)
    # if no_overlapping_bookings
    #   flash[:success] = 'Booked!'
    #   redirect_to room_path(@room)
    # else
    #   flash[:alert] = "This booking overlaps others"
    #   render 'new'
    # end

    # if @booking.save
    #   flash[:success] = 'Booked!'
    #   redirect_to bookings_path
    # else
    #   flash[:alert] = "This booking overlaps others"
    #   render 'new'
    # end
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
    @status = Booking.status?
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
