class SchedulesController < ApplicationController

  before_action :not_setting_goals_in_life!

  def new
    @schedule = Schedule.new
    @problems = current_user.problems.activity.order(created_at: :desc)
  end

  def create
    schedule = Schedule.new(schedule_params)
    schedule.user_id = current_user.id
    if schedule.save(context: :create_schedule)
      redirect_to schedule_path(schedule)
    else
      redirect_to new_schedule_path(error: true)
    end
  end

  def index
    @schedules = Schedule.where(user_id: current_user)
  end

  def show
    @plan = Plan.new
    @schedule = Schedule.includes(:plans).find(params[:id])
  end

  def edit
    @schedule = Schedule.find(params[:id])
    @problems = current_user.problems.activity.order(created_at: :desc)
  end

  def update
    schedule = Schedule.find(params[:id])
    if schedule.update(schedule_params)
      redirect_to schedule_path(schedule.id)
    else
      redirect_to edit_schedule_path(schedule.id , error: true)
    end
  end

  # 複数のplanテーブルを更新する
  def all_update
    schedule = Schedule.find(params[:id])
    schedule.update(schedule_params)
    redirect_to schedule_path(schedule.id)
  end

  def destroy
    schedule = Schedule.find(params[:id])
    schedule.destroy
    redirect_to schedules_path
  end

  private

  # ログインユーザーがmission_statementのカラムと目標を作成していない場合のアクセス制限
  def not_setting_goals_in_life!
    if !current_user.mission_statement.present? || !current_user.problems.present?
      redirect_to welcome_path
    end
  end

  # ストロングパロメータにネストしているPlanモデルをattributesし、スケジュールからplansテーブルの編集を可能にする
  def schedule_params
    params.require(:schedule).permit(:problem_id,:title,:body,:start_datetime,:start_time,:end_datetime,:end_time, plans_attributes: [:id, :priority_status, :progress_status])
  end

end
