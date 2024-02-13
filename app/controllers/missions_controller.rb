class MissionsController < ApplicationController

  def create
    problem = Problem.find(params[:problem_id])
    mission = Mission.new(mission_param)
    mission.problem_id = problem.id
    if mission.save
      redirect_to problem_path(problem.id)
    else
      render template: 'problem/show'
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

    redirect_to problem_path(problem.id)

  end

  # 単一のmissionテーブルを削除する
  def destroy
    problem = Problem.find(params[:problem_id])
    mission = Mission.find(params[:id])
    mission.destroy
    redirect_to problem_path(problem.id)
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

    redirect_to problem_path(problem.id)
  end

  # 複数のmissionテーブルを削除する
  def bulk_destroy
    problem = Problem.find(params[:problem_id])
    mission = problem.missions
    mission.destroy_all
    redirect_to problem_path(problem.id)
  end

  private

  def mission_params
    params.require(:mission).permit(:memo)
  end

end