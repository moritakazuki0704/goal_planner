class IdealsController < ApplicationController

  before_action :not_setting_goals_in_life!
  before_action :ideal_new, except: [:create,:confirm,:destroy,:show]

  def personality_new
  end

  def appearance_new
  end

  def lifestyle_new
  end

  def spend_time_new
  end

  def working_new
  end

  def residence_new
  end

  def relationship_new
  end

  def partner_new
  end

  def role_model_new
  end

  def create
    ideal = Ideal.new(ideal_params)
    ideal.user_id = current_user.id
    if ideal.save
      redirect_to ideals_path
    else
      redirect_to ideals_path(error: true)
    end
  end

  def index
    @ideals = current_user.ideals
  end
  
  def show
    @ideal = Ideal.find(params[:id])
  end

  def destroy
    ideal = Ideal.find(params[:id])
    ideal.destroy
    redirect_to ideals_path
  end

  private

  def ideal_new
    @ideal = Ideal.new
  end

  # ログインユーザーがmission_statementのカラム、または目標を作成していない場合のアクセス制限
  def not_setting_goals_in_life!
    if !current_user.mission_statement.present? || !current_user.problems.present?
      redirect_to welcome_path
    end
  end

  def ideal_params
    params.require(:ideal).permit(:ideal_status,:ideal_self_1,:ideal_self_2,:ideal_self_3)
  end

end
