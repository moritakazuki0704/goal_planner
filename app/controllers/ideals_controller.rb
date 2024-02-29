class IdealsController < ApplicationController

  before_action :not_setting_goals_in_life!
  before_action :ideal_new, only: [:personality_new,:appearance_new,:lifestyle_new,:spend_time_new,:working_new,:residence_new,:relationship_new,:partner_new,:role_model_new]
  before_action :ideal_create, only: [:personality_create,:appearance_create,:lifestyle_create,:spend_time_create,:working_create,:residence_create,:relationship_create,:partner_create,:role_model_create]

  def personality_new
  end

  def personality_create
    if ideal.save
      if params[:restart]
        redirect_to personality_new_ideals_path
      else
        redirect_to show_ideal_path(ideal.ideal_status)
      end
    else
      redirect_to personality_new_ideals_path(error: true)
    end
  end

  def appearance_new
  end

  def appearance_create
    if ideal.save
      if params[:restart]
        redirect_to appearance_new_ideals_path
      else
        redirect_to show_ideal_path(ideal.ideal_status)
      end
    else
      redirect_to appearance_new_ideals_path(error: true)
    end
  end

  def lifestyle_new
  end

  def lifestyle_create
    if ideal.save
      if params[:restart]
        redirect_to lifestyle_new_ideals_path
      else
        redirect_to show_ideal_path(ideal.ideal_status)
      end
    else
      redirect_to lifestyle_new_ideals_path(error: true)
    end
  end

  def spend_time_new
  end

  def spend_time_create
    if ideal.save
      if params[:restart]
        redirect_to spend_time_new_ideals_path
      else
        redirect_to show_ideal_path(ideal.ideal_status)
      end
    else
      redirect_to spend_time_new_ideals_path(error: true)
    end
  end

  def working_new
  end

  def working_create
    if ideal.save
      if params[:restart]
        redirect_to working_new_ideals_path
      else
        redirect_to show_ideal_path(ideal.ideal_status)
      end
    else
      redirect_to working_new_ideals_path(error: true)
    end
  end

  def residence_new
  end

  def residence_create
    if ideal.save
      if params[:restart]
        redirect_to residence_new_ideals_path
      else
        redirect_to show_ideal_path(ideal.ideal_status)
      end
    else
      redirect_to residence_new_ideals_path(error: true)
    end
  end

  def relationship_new
  end

  def relationship_create
    if ideal.save
      if params[:restart]
        redirect_to relationship_new_ideals_path
      else
        redirect_to show_ideal_path(ideal.ideal_status)
      end
    else
      redirect_to relationship_new_ideals_path(error: true)
    end
  end

  def partner_new
  end

  def partner_create
    if ideal.save
      if params[:restart]
        redirect_to partner_new_ideals_path
      else
        redirect_to show_ideal_path(ideal.ideal_status)
      end
    else
      redirect_to partner_new_ideals_path(error: true)
    end
  end

  def role_model_new
  end

  def role_model_create
    if ideal.save
      if params[:restart]
        redirect_to role_model_new_ideals_path
      else
        redirect_to show_ideal_path(ideal.ideal_status)
      end
    else
      redirect_to role_model_new_ideals_path(error: true)
    end
  end

  def index
    @ideals = current_user.ideals
  end

  def show
    user_ideal = current_user.ideals
    @ideals = user_ideal.find_by(ideal_status: params[:ideal_status])
    @random_ideals = @ideals.order("RANDOM()").page(params[:page])
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

  def ideal_create
    ideal = Ideal.new(ideal_params)
    ideal.user_id = current_user.id
  end

  # ログインユーザーがmission_statementのカラム、または目標を作成していない場合のアクセス制限
  def not_setting_goals_in_life!
    if !current_user.mission_statement.present? || !current_user.problems.present?
      redirect_to welcome_path
    end
  end

  def ideal_params
    params.require(:ideal).permit(:ideal_status,:ideal_self)
  end

end
