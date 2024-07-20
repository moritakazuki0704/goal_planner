class IdealsController < ApplicationController

  before_action :not_setting_goals_in_life!
  before_action :ideal_new, only: [:personality_new, :appearance_new, :lifestyle_new, :spend_time_new, :working_new, :residence_new, :relationship_new, :partner_new, :role_model_new]

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

  def working_create
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
      redirect_to relationship_new_ideals_path(record: true)
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

    # 理想の性格を確認する場合
    if params[:personality]
      @ideal_name = user_ideal.find_by(ideal_status: 0)
      @ideals = user_ideal.personality.page(params[:page])

    # 理想の姿を確認する場合
    elsif params[:appearance]
      @ideal_name = user_ideal.find_by(ideal_status: 1)
      @ideals = user_ideal.appearance.page(params[:page])

    # 理想のライフスタイルを確認する場合
    elsif params[:lifestyle]
      @ideal_name = user_ideal.find_by(ideal_status: 2)
      @ideals = user_ideal.lifestyle.page(params[:page])

    # 理想の時間の使い方を確認する場合
    elsif params[:spend_time]
      @ideal_name = user_ideal.find_by(ideal_status: 3)
      @ideals = user_ideal.spend_time.page(params[:page])

    # 理想の働き方を確認する場合
    elsif params[:working]
      @ideal_name = user_ideal.find_by(ideal_status: 4)
      @ideals = user_ideal.working.page(params[:page])

    # 理想の住まいを確認する場合
    elsif params[:residence]
      @ideal_name = user_ideal.find_by(ideal_status: 5)
      @ideals = user_ideal.residence.page(params[:page])

    # 理想の人間関係を確認する場合
    elsif params[:relationship]
      @ideal_name = user_ideal.find_by(ideal_status: 6)
      @ideals = user_ideal.relationship.page(params[:page])

    # 理想のパートナーを確認する場合
    elsif params[:partner]
      @ideal_name = user_ideal.find_by(ideal_status: 7)
      @ideals = user_ideal.partner.page(params[:page])

    # 理想のロールモデルを確認する場合
    elsif params[:role_model]
      @ideal_name = user_ideal.find_by(ideal_status: 8)
      @ideals = user_ideal.role_model.page(params[:page])
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

  # ログインユーザーがmission_statementのカラムと目標を作成していない場合のアクセス制限
  def not_setting_goals_in_life!
    if !current_user.mission_statement.present? || !current_user.problems.present?
      redirect_to welcome_path
    end
  end

  def ideal_params
    params.require(:ideal).permit(:ideal_status, :ideal_self, :ideal_detail_self)
  end

end
