class MissionsController < ApplicationController

  before_action :not_setting_goals_in_life!

  def create
    problem = Problem.find(params[:problem_id])
    mission = Mission.new(mission_params)
    mission.problem_id = problem.id
    if mission.save
      redirect_to problem_path(problem)
    else
      redirect_to problem_path(problem,error: true)
    end
  end

  # 単一のmissionテーブルをscheduleに保存する
  def upload
    problem = Problem.find(params[:problem_id])
    mission = Mission.find(params[:id])

    # missionのデータをscheduleのテーブルに保存
    schedule = Schedule.new
    schedule.user_id = current_user.id
    schedule.problem_id = mission.problem_id
    schedule.title = mission.memo
    schedule.save

    # 保存が終わったmissionのデータを削除
    mission.destroy

    redirect_to problem_path(problem)

  end

  # 単一のmissionテーブルを削除する
  def destroy
    problem = Problem.find(params[:problem_id])
    mission = Mission.find(params[:id])
    mission.destroy
    redirect_to problem_path(problem)
  end

  # 複数のmissionテーブルをscheduleに保存する
  def bulk_upload
    problem = Problem.find(params[:problem_id])

    # 閲覧中のproblemが保持しているmissionのデータをscheduleのテーブルに保存
    problem.missions.each do |mission|
      schedule = Schedule.new
      schedule.user_id = current_user.id
      schedule.problem_id = mission.problem_id
      schedule.title = mission.memo
      schedule.save
    end

    # 閲覧中のproblemが保持しているmissionのデータを全て削除
    problem.missions.destroy_all

    redirect_to problem_path(problem)
  end

  # 複数のmissionテーブルを削除する
  def bulk_destroy
    problem = Problem.find(params[:problem_id])
    mission = problem.missions
    mission.destroy_all
    redirect_to problem_path(problem)
  end

  private

  # ログインユーザーがmission_statementのカラムと目標を作成していない場合のアクセス制限
  def not_setting_goals_in_life!
    if !current_user.mission_statement.present? || !current_user.problems.present?
      redirect_to welcome_path
    end
  end

  def mission_params
    params.require(:mission).permit(:memo)
  end

end