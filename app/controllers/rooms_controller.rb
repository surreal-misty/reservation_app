class RoomsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :own ]

  def own
  @rooms = current_user.rooms
end

  def index
    @rooms = Room.all
    if params[:keyword].present?
    @rooms = @rooms.where("name LIKE ? OR description LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end

  if params[:address].present?
    @rooms = @rooms.where("address LIKE ?", "%#{params[:address]}%")
  end
end

  def show
    @room = Room.find(params[:id])
    if user_signed_in?
    @reservation = current_user.reservations.build
    end
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save
      redirect_to @room, notice: "施設を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image)
  end
end
