class AttendancesController < ApplicationController
  before_action :set_user, only: [:edit_one_month, :update_one_month, :edit]
  before_action :set_spot, only: [:index, :edit]
  before_action :logged_in_user, only: [:update, :edit_one_month]
  before_action :admin_or_correct_user, only: [:update, :edit_one_month, :update_one_month]
  before_action :set_one_month, only: [:edit_one_month, :index]
  
  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"
  
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
    @user = User.find(params[:user_id])
    @reservation = Reservation.find(params[:id])

    if @attendance.save
      flash[:success] = "予約が完了いたしました。"
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
  
  private
  
    def attendances_params
      params.require(:attendance).permit(:worked_on, :started_at, :name, :tel, :note)
    end
    
    def admin_or_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end
    end
end
