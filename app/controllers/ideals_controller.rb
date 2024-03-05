class IdealsController < ApplicationController

  before_action :not_setting_goals_in_life!
  before_action :ideal_new, only: [:personality_new,:appearance_new,:lifestyle_new,:spend_time_new,:working_new,:residence_new,:relationship_new,:partner_new,:role_model_new]

  def personality_new
  end

  def personality_create
    ideal = Ideal.new(ideal_params)
    ideal.user_id = current_user.id
    ideal.ideal_status = 0
    if ideal.save
      redirect_to personality_new_ideals_path(record: true)
    else
      redirect_to personality_new_ideals_path(error: true)
    end
  end

  def appearance_new
  end

  def appearance_create
    ideal = Ideal.new(ideal_params)
    ideal.user_id = current_user.id
    ideal.ideal_status = 1
    if ideal.save
      redirect_to appearance_new_ideals_path(record: true)
    else
      redirect_to appearance_new_ideals_path(error: true)
    end
  end

  def lifestyle_new
  end

  def lifestyle_create
    ideal = Ideal.new(ideal_params)
    ideal.user_id = current_user.id
    ideal.ideal_status = 2
    if ideal.save
      redirect_to lifestyle_new_ideals_path(record: true)
    else
      redirect_to lifestyle_new_ideals_path(error: true)
    end
  end

  def spend_time_new
  end

  def spend_time_create
    ideal = Ideal.new(ideal_params)
    ideal.user_id = current_user.id
    ideal.ideal_status = 3
    if ideal.save
      redirect_to spend_time_new_ideals_path(record: true)
    else
      redirect_to spend_time_new_ideals_path(error: true)
    end
  end

  def working_new
  end

  def working_creat
    ideal = Ideal.new(ideal_params)
    ideal.user_id = current_user.id
    ideal.ideal_status = 4
    if ideal.save
      redirect_to working_new_ideals_path(record: true)
    else
      redirect_to working_new_ideals_path(error: true)
    end
  end

  def residence_new
  end

  def residence_create
    ideal = Ideal.new(ideal_params)
    ideal.user_id = current_user.id
    ideal.ideal_status = 5
    if ideal.save
      redirect_to residence_new_ideals_path(record: true)
    else
      redirect_to residence_new_ideals_path(error: true)
    end
  end

  def relationship_new
  end

  def relationship_create
    ideal = Ideal.new(ideal_params)
    ideal.user_id = current_user.id
    ideal.ideal_status = 6
    if ideal.save
      if params[:restart]
        redirect_to relationship_new_ideals_path(record: true)
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
    ideal = Ideal.new(ideal_params)
    ideal.user_id = current_user.id
    ideal.ideal_status = 7
    if ideal.save
      redirect_to partner_new_ideals_path(record: true)
    else
      redirect_to partner_new_ideals_path(error: true)
    end
  end

  def role_model_new
  end

  def role_model_create
    ideal = Ideal.new(ideal_params)
    ideal.user_id = current_user.id
    ideal.ideal_status = 8
    if ideal.save
      redirect_to role_model_new_ideals_path(record: true)
    else
      redirect_to role_model_new_ideals_path(error: true)
    end
  end

  def index
    @ideals = Ideal.where(user_id: current_user)
  end

  def record
    user_ideal = Ideal.where(user_id: current_user)
    if params[:personality]
      @ideals = user_ideal.personality.order("RANDOM()").page(params[:page])
    elsif params[:appearance]
      @ideals = user_ideal.appearance.order("RANDOM()").page(params[:page])
    elsif params[:lifestyle]
      @ideals = user_ideal.lifestyle.order("RANDOM()").page(params[:page])
    elsif params[:spend_time]
      @ideals = user_ideal.spend_time.order("RANDOM()").page(params[:page])
    elsif params[:working]
      @ideals = user_ideal.working.order("RANDOM()").page(params[:page])
    elsif params[:residence]
      @ideals = user_ideal.residence.order("RANDOM()").page(params[:page])
    elsif params[:relationship]
      @ideals = user_ideal.relationship.order("RANDOM()").page(params[:page])
    elsif params[:partner]
      @ideals = user_ideal.partner.order("RANDOM()").page(params[:page])
    elsif params[:role_model]
      @ideals = user_ideal.role_model.order("RANDOM()").page(params[:page])
    end
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
    params.require(:ideal).permit(:ideal_status,:ideal_self,:ideal_detail_self)
  end

end
