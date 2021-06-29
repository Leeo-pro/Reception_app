class AttendancesController < ApplicationController
  before_action :set_user, only: [:edit_one_month, :update_one_month, :edit]
  before_action :set_spot, only: [:index, :edit]
  before_action :logged_in_user, only: [:update, :edit_one_month]
  before_action :admin_or_correct_user, only: [:update, :edit_one_month, :update_one_month]
  before_action :set_one_month, only: [:edit_one_month, :index]
  
  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"
  def index
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
    redirect_to user_reservation_path(@user, @reservation)
  end
  
  def edit
    @attendance = Attendance.new
    @reservation = Reservation.find(params[:id])
  end  
  
  def new
    @attendance = Attendance.new
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
  end
  
  def create
    @attendance = Attendance.new(attendance_params)
    @YEAR = params[:attendance][:worked_on].to_date.year
    @MONTH = params[:attendance][:worked_on].to_date.month
    @DAY = params[:attendance][:worked_on].to_date.day
    @HOUR = params[:attendance]['started_at(4i)'].to_i
    @MIN = params[:attendance]['started_at(5i)'].to_i
    @attendance.started_at = DateTime.new(@YEAR, @MONTH, @DAY, @HOUR, @MIN, 0).strftime("%H:%M")
    
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])

    if @attendance.name.blank?
      flash[:danger] = "名前が入力されていません。"
      redirect_to new_user_attendance_path(@user, @reservation, @attendance.worked_on)
    elsif @HOUR == 0
      flash[:danger] = "予約時間が入力されていません。"
      redirect_to new_user_attendance_path(@user, @reservation, @attendance.worked_on)
    elsif Attendance.where(started_at: @attendance.started_at).count >= 1
      flash[:danger] = "既に予約済です。"
      redirect_to new_user_attendance_path(@user, @reservation, @attendance.worked_on)
    elsif @attendance.save
      flash[:success] = "予約が完了いたしました。"
      redirect_to user_reservation_path(@user, @reservation)
    else
      flash[:danger] = "更新できませんでした"
      render :new
    end
  end
  
  def edit_one_month
  end
  
  def update_one_month
    ActiveRecord::Base.transaction do
      attendances_params.each do |id, item|
        attendance = Attendance.find(id)
        attendance.update_attributes!(item)
      end
    end
    flash[:success] = "1ヶ月分の勤怠情報を更新しました。"
    redirect_to user_url(date: params[:date])
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    redirect_to attendances_edit_one_month_user_url(date: params[:date])
  end

  def destroy
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    @reservation = Reservation.find(@attendance.reservation_id)
    @attendance.destroy
    flash[:success] = "#{@attendance.build_name}の予約情報を削除しました。"
    redirect_to user_reservation_path(@user, @reservation)
  end
  
  def edit_order_info
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
    @attendance = Attendance.find(params[:attendance_id])
  end

  def update_order_info
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])
    @attendance = Attendance.find(params[:attendance_id])
    if @attendance.update_attributes(attendance_params)
      flash[:success] = "#{@attendance.build_name}の予約情報を更新しました。"
    else
      flash[:danger] = "#{@attendance.build_name}の更新は失敗しました。<br>" + @attendance.errors.full_messages.join("<br>")
    end
    redirect_to user_reservation_path(@user, @reservation)
  end

  private
  
    def attendance_params
      params.require(:attendance).permit(:worked_on, :started_at, :name, :tel, :note, :user_id, :build_name, :reservation_id)
    end
    
    def admin_or_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end
    end
end
