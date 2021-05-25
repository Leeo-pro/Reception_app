class ReservationsController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_spot, only: [:show]
  before_action :set_one_month, only: [:show]
  
  
  def index
    @user = User.find(params[:user_id])
    @reservations = Reservation.paginate(page: params[:page]).search(params[:search])
    #@reservations = @reservations.where('name LIKE ?',  "%#{params[:search]}%") if params[:search].present?
    
    #@reservations = Reservation.all

    #@reservations = Reservation.where('title LIKE ?', "%#{params[:search]}%") if params[:search].present?
  end
  
  def search
    @reservations = Reservation.search(params[:search])
  end
  
  def show
    #@user = User.find(params[:user_id])
  end

  
end
