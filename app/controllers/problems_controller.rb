class ProblemsController < ApplicationController

  before_action :not_design_your_ideal_life!

  def new
    @problem = Problem.new
  end

  def confirm
    session[:commitment] = problem_params[:commitment]
    session[:purpose] = problem_params[:purpose]
    @problem = Problem.new
  end

  def create
    problem = Problem.new(
      commitment: session[:commitment],
      purpose: session[:purpose]
      )
    problem.user_id = current_user.id

    # 初回にproblemテーブルを作成した場合
    if !current_user.problems.present?
      problem.save
      redirect_to welcome_path

    # problemテーブルをすでに持っている場合
    else
      problem.save
      redirect_to welcome_path
    end

  end

  def index
    @problems = Problem.where(user_id: current_user)
  end

  def show
    @problem = Problem.find(params[:id])
    @mission = Mission.new
  end

  def update
    problem = Problem.find(params[:id])
    problem.update(problem_params)
    redirect_to problems_path
  end

  private

  # ログインユーザーがidealテーブル、またはmission_statementのカラムを作成していない場合のアクセス制限
  def not_design_your_ideal_life!
    if !current_user.ideal.present? || !current_user.mission_statement.present?
      redirect_to welcome_path
    end
  end

  def problem_params
    params.require(:problem).permit(:commitment,:purpose,:progress_status)
  end

end
