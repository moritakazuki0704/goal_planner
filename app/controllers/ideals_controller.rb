class IdealsController < ApplicationController

  before_action :ideal_uncreated_user!,only: [:show]
  before_action :ideal_new, except: [:create,:confirm,:destroy,:show]
  before_action :ideal_find, only: [:confirm,:destroy,:show]

  def step1_keyword
  end

  def step2_personality
    session[:keyword_1] = ideal_params[:keyword_1]
    session[:keyword_2] = ideal_params[:keyword_2]
    session[:keyword_3] = ideal_params[:keyword_3]
    session[:keyword_4] = ideal_params[:keyword_4]
    session[:keyword_5] = ideal_params[:keyword_5]
    session[:keyword_6] = ideal_params[:keyword_6]
    session[:keyword_7] = ideal_params[:keyword_7]
    session[:keyword_8] = ideal_params[:keyword_8]
    session[:keyword_9] = ideal_params[:keyword_9]
    session[:keyword_10] = ideal_params[:keyword_10]
  end

  def step3_appearance
    session[:personality_1] = ideal_params[:personality_1]
    session[:personality_2] = ideal_params[:personality_2]
    session[:personality_3] = ideal_params[:personality_3]
  end

  def step4_lifestyle
    session[:hair_make] = ideal_params[:hair_make]
    session[:body_make] = ideal_params[:body_make]
    session[:fashion_make] = ideal_params[:fashion_make]
  end

  def step5_time
    session[:lifestyle_1] = ideal_params[:lifestyle_1]
    session[:lifestyle_2] = ideal_params[:lifestyle_2]
    session[:lifestyle_3] = ideal_params[:lifestyle_3]
  end

  def step6_working
    session[:time_1] = ideal_params[:time_1]
    session[:time_2] = ideal_params[:time_2]
    session[:time_3] = ideal_params[:time_3]
  end

  def step7_residence
    session[:working_1] = ideal_params[:working_1]
    session[:working_2] = ideal_params[:working_2]
    session[:working_3] = ideal_params[:working_3]
  end

  def step8_relationship
    session[:residence_1] = ideal_params[:residence_1]
    session[:residence_2] = ideal_params[:residence_2]
    session[:residence_3] = ideal_params[:residence_3]
  end

  def step9_partner
    session[:relationship_1] = ideal_params[:relationship_1]
    session[:relationship_2] = ideal_params[:relationship_2]
    session[:relationship_3] = ideal_params[:relationship_3]
  end

  def step10_role_model
    session[:partner_1] = ideal_params[:partner_1]
    session[:partner_2] = ideal_params[:partner_2]
    session[:partner_3] = ideal_params[:partner_3]
  end

  def create
    ideal = Ideal.new(
    keyword_1: session[:keyword_1],
    keyword_2: session[:keyword_2],
    keyword_3: session[:keyword_3],
    keyword_4: session[:keyword_4],
    keyword_5: session[:keyword_5],
    keyword_6: session[:keyword_6],
    keyword_7: session[:keyword_7],
    keyword_8: session[:keyword_8],
    keyword_9: session[:keyword_9],
    keyword_10: session[:keyword_10],
    personality_1: session[:personality_1],
    personality_2: session[:personality_2],
    personality_3: session[:personality_3],
    hair_make: session[:hair_make],
    body_make: session[:body_make],
    fashion_make: session[:fashion_make],
    lifestyle_1: session[:lifestyle_1],
    lifestyle_2: session[:lifestyle_2],
    lifestyle_3: session[:lifestyle_3],
    time_1: session[:time_1],
    time_2: session[:time_2],
    time_3: session[:time_3],
    working_1: session[:working_1],
    working_2: session[:working_2],
    working_3: session[:working_3],
    residence_1: session[:residence_1],
    residence_2: session[:residence_2],
    residence_3: session[:residence_3],
    relationship_1: session[:relationship_1],
    relationship_2: session[:relationship_2],
    relationship_3: session[:relationship_3],
    partner_1: session[:partner_1],
    partner_2: session[:partner_2],
    partner_3: session[:partner_3],
    partner_model: ideal_params[:partner_model],
    family_model: ideal_params[:family_model],
    friend_model: ideal_params[:friend_model]
    )
    ideal.user_id = current_user.id
    ideal.save
    redirect_to confirm_ideal_path
  end

  def confirm
  end

  def destroy
    @ideal.destroy
    redirect_to welcome_path
  end

  def show
    @user = current_user
  end

  private

  def ideal_new
    @ideal = Ideal.new
  end

  def ideal_find
    @ideal = Ideal.find_by(user_id: current_user)
  end

  # ログインユーザーがidealテーブルを作成していない場合のアクセス制限
  def ideal_uncreated_user!
    if !current_user.ideal.present?
      redirect_to welcome_path
    end
  end

  def ideal_params
    params.require(:ideal).permit(:keyword_1,:keyword_2,:keyword_3,:keyword_4,:keyword_5,:keyword_6,:keyword_7,:keyword_8,:keyword_9,:keyword_10,
                                  :personality_1,:personality_2,:personality_3,
                                  :hair_make,:body_make,:fashion_make,
                                  :lifestyle_1,:lifestyle_2,:lifestyle_3,
                                  :time_1,:time_2,:time_3,
                                  :working_1,:working_2,:working_3,
                                  :residence_1,:residence_2,:residence_3,
                                  :relationship_1,:relationship_2,:relationship_3,
                                  :partner_1,:partner_2,:partner_3,
                                  :partner_model,:family_model,:friend_model)
  end

end
