class SchedulesController < ApplicationController

  before_action :not_design_your_ideal_life!
  before_action :schedule_find, only: [:show,:edit,:update,:destroy]

  def new
    @schedule = Schedule.new
    @problems = current_user.problems.activity.order(created_at: :desc)
  end

  def create
    schedule = Schedule.new(schedule_params)
    schedule.user_id = current_user.id
    if schedule.start_date > schedule.end_date || schedule.start_date == schedule.end_date && schedule.start_time >= schedule.end_time
      redirect_to new_schedule_path(error: true)
    elsif schedule.save(context: :create_schedule)
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
  end

  def edit
    @problems = current_user.problems.activity.order(created_at: :desc)
  end

  def update
    @problems = current_user.problems.activity.order(created_at: :desc)
    if @schedule.start_date > @schedule.end_date || @schedule.start_date == @schedule.end_date && @schedule.start_time >= @schedule.end_time
      redirect_to edit_schedule_path(@schedule , error: true)
    elsif @schedule.update(schedule_params)
      redirect_to schedule_path(@schedule)
    else
      redirect_to edit_schedule_path(@schedule , error: true)
    end
  end

  def destroy
    @schedule.destroy
    redirect_to schedules_path
  end

  private

  def schedule_find
    @schedule = Schedule.find(params[:id])
  end

  # ログインユーザーがidealテーブル、またはmission_statementのカラム、または目標を作成していない場合のアクセス制限
  def not_design_your_ideal_life!
    if !current_user.ideal.present? || !current_user.mission_statement.present? || !current_user.problems.present?
      redirect_to welcome_path
    end
  end

  def schedule_params
    params.require(:schedule).permit(:problem_id,:title,:body,:start_date,:start_time,:end_date,:end_time)
  end

end
