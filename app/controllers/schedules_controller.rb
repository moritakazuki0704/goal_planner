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
    if schedule.save(context: :create_schedule)
      redirect_to schedule_path(schedule)
    else
      render :new
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
    if @schedule.update(schedule_params , context: :create_schedule)
      redirect_to schedule_path(@schedule)
    else
      render :edit
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
    params.require(:schedule).permit(:problem_id,:title,:body,:start_time,:finish_time,:is_all_day)
  end

end
