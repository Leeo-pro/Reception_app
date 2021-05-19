class ReservationsController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_spot, only: [:show]
  before_action :set_one_month, only: [:show]
  
  
  def index
    @reservations = Reservation.paginate(page: params[:page])
  end
  
  def show
    #@user = User.find(params[:user_id])
  end

  
end
