class RoomsController < ApplicationController

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:success] = 'Added!'
      redirect_to rooms_path
    else
      flash[:alert] = "This room already exists!"
      # render 'new'
      redirect_to new_room_path
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    @room.update(room_params)
    flash[:success] = 'Room updated!'
    redirect_to rooms_path
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:success] = 'Room deleted!'
    redirect_to rooms_path
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
