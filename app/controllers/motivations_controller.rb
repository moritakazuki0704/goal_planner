class MotivationsController < ApplicationController

  before_action :not_setting_goals_in_life!
  before_action :motivation_new, only: [:positive_new,:negative_new,:to_do_new,:want_new]

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
      redirect_to motivations_path
    else
      redirect_to motivations_path(error: true)
    end
  end

  def index
    @motivations = Motivation.where(user_id: current_user)
  end

  def own
    user_motivation = Motivation.where(user_id: current_user)
    if params[:positive]
      @motvations = user_motivation.positive.order("RANDOM()").page(params[:page])
    elsif params[:negative]
      @motvations = user_motivation.negative.order("RANDOM()").page(params[:page])
    elsif params[:to_do]
      @motvations = user_motivation.to_do.order("RANDOM()").page(params[:page])
    elsif params[:want]
      @motvations = user_motivation.want.order("RANDOM()").page(params[:page])
    end
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

  # ログインユーザーがmission_statementのカラム、または目標を作成していない場合のアクセス制限
  def not_setting_goals_in_life!
    if !current_user.mission_statement.present? || !current_user.problems.present?
      redirect_to welcome_path
    end
  end

  def motivation_params
    params.require(:motivation).permit(:emotion_stetas,:appetite,:memory)
  end

end