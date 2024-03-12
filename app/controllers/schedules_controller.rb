class SchedulesController < ApplicationController

  before_action :not_setting_goals_in_life!
  before_action :schedule_find, only: [:show,:edit,:update,:destroy]

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
    @plans = @schedule.plans
  end

  def edit
    @problems = current_user.problems.activity.order(created_at: :desc)
  end

  def update
    @problems = current_user.problems.activity.order(created_at: :desc)
    if @schedule.update(schedule_params)
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

  # ログインユーザーがmission_statementのカラム、または目標を作成していない場合のアクセス制限
  def not_setting_goals_in_life!
    if !current_user.mission_statement.present? || !current_user.problems.present?
      redirect_to welcome_path
    end
  end

  def schedule_params
    params.require(:schedule).permit(:problem_id,:title,:body,:start_datetime,:start_time,:end_datetime,:end_time)
  end

end
