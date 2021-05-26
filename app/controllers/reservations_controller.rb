class ReservationsController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_spot, only: [:show]
  before_action :set_one_month, only: [:show]
  
  
  def new
    @user = User.find(params[:user_id])
    @reservation = Reservation.new
  end
  
  def create
    @user = User.find(params[:user_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.save
    flash[:success] = "登録が完了しました。"
    redirect_to user_reservations_path(@user)
  end
    
  def index
    @user = User.find(params[:user_id])
    @reservation = Reservation.where.not(name: nil)
    @reservations = @reservation.paginate(page: params[:page]).search(params[:search])
    #@reservations = @reservations.where('name LIKE ?',  "%#{params[:search]}%") if params[:search].present?
    
    #@reservations = Reservation.all

    #@reservations = Reservation.where('title LIKE ?', "%#{params[:search]}%") if params[:search].present?
  end
  
  def search
    @reservations = Reservation.search(params[:search])
  end
  
  def show
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
  end
  
  def destroy
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:success] = "#{@reservation.name}の情報を削除しました。"
    redirect_to user_reservations_path(@user, @reservation)
  end
  
  def edit_area_info
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
  end

  def update_area_info
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
    if @reservation.update_attributes(reservation_params)
      flash[:success] = "#{@reservation.name}の拠点情報を更新しました。"
    else
      flash[:danger] = "#{@reservation.name}の更新は失敗しました。<br>" + @reservation.errors.full_messages.join("<br>")
    end
    redirect_to user_reservations_path(@user, @reservation)
  end

  def close_info
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
    if @reservation.close.nil?
      if @reservation.update_attributes(close: "1")
      end
    elsif @reservation.close.present?
      if @reservation.update_attributes(close: nil)
      end
    end
    redirect_to user_reservation_path(@user, @reservation)
  end

  private
    def reservation_params
      params.require(:reservation).permit(:name, :str_time, :fin_time, day: [])
    end
  
end
