class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations
  end

  def confirm
    @room = Room.find(reservation_params[:room_id])
    @reservation = current_user.reservations.build(reservation_params)

    if @reservation.valid?
      render :confirm
    else
      render "rooms/show", status: :unprocessable_entity
    end
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)

    if @reservation.save
      redirect_to reservations_path
    else
      render "rooms/show", status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(
      :room_id,
      :start_date,
      :end_date,
      :person_num
    )
  end
end
