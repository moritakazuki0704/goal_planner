class MotivationsController < ApplicationController

  before_action :not_design_your_ideal_life!
  before_action :motivation_new, only: [:positive_new,:negative_new,:to_do_new,:want_new]
  before_action :user_signed_motivation, except: [:show,:destroy]

  def positive_new
  end

  def negative_new
  end

  def to_do_new
  end

  def want_new
  end

  def create
    motivation = Motivation.new(motivation_params)
    motivation.user_id = current_user.id
    if motivation.save
      redirect_to motivation_path(motivation.id)
    else
      redirect_to motivations_path(error: true)
    end
  end

  def index
    @motivations = @user_motivation.order("RANDOM()")
  end

  def show
    @motivation = Motivation.find(params[:id])
  end

  def destroy
    motivation = Motivation.find(params[:id])
    motivation.destroy
    redirect_to motivations_path
  end

  private

  def motivation_new
    @motivation = Motivation.new
  end

  def user_signed_motivation
    @user_motivation = Motivation.where(user_id: current_user)
  end

  # ログインユーザーがidealテーブル、またはmission_statementのカラム、または目標を作成していない場合のアクセス制限
  def not_design_your_ideal_life!
    if !current_user.ideal.present? || !current_user.mission_statement.present? || !current_user.problems.present?
      redirect_to welcome_path
    end
  end

  def motivation_params
    params.require(:motivation).permit(:emotion_stetas,:appetite,:memory)
  end

end