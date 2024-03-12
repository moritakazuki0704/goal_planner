class PlansController < ApplicationController

  before_action :not_setting_goals_in_life!

  def create
    schedule = Schedule.find(params[:schedule_id])
    plan = Plan.new(plan_params)
    plan.schedule_id = schedule.id
    if plan.save
     redirect_to schedule_path(schedule)
    else
     redirect_to schedule_path(schedule,error: true)
    end
  end

  # 単一のplanテーブルを稼働させる
  def upload
    schedule = Schedule.find(params[:schedule_id])
    plan = Plan.find(params[:id])
    plan.update(programme: "true")
    redirect_to schedule_path(schedule)
  end

  # 単一のplanテーブルを削除する
  def destroy
    schedule = Schedule.find(params[:schedule_id])
    plan = Plan.find(params[:id])
    plan.destroy
    redirect_to schedule_path(schedule)
  end

  # 複数のplanテーブルを稼働させる
  def bulk_upload
    schedule = Schedule.find(params[:schedule_id])
    plan = schedule.plans.where(programme: "false")
    plan.update(programme: "true")
    redirect_to schedule_path(schedule)
  end

  # 複数のplanテーブルを削除する
  def bulk_destroy
    schedule = Schedule.find(params[:schedule_id])
    plan = schedule.plans.where(programme: "false")
    plan.destroy_all
    redirect_to schedule_path(schedule)
  end

  # 複数のplanテーブルを更新する
  def all_update
    schedule = Schedule.find(params[:schedule_id])
    plan = schedule.plans.where(programme: "true")
    plan.update(plan_params)
    redirect_to schedule_path(schedule)
  end

  private

  # ログインユーザーがmission_statementのカラム、または目標を作成していない場合のアクセス制限
  def not_setting_goals_in_life!
    if !current_user.mission_statement.present? || !current_user.problems.present?
      redirect_to welcome_path
    end
  end

  def plan_params
    params.require(:plan).permit(:challenge,:priority_status,:progress_status,:programme)
  end
end