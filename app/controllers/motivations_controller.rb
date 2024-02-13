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
    elsif motivation.motivation.stetas(0)
      render :positive_new
    elsif motivation.motivation.stetas(1)
      render :negative_new
    elsif motivation.motivation.stetas(2)
      render :to_do_new
    elsif motivation.motivation.stetas(3)
      render :want_new
    end
  end

  def index
    @motivations = @user_motivation.order("RANDOM()").limit(5)
  end


  def list

    # リンクから渡されたデータによって、表示する内容を変更
    if params[:positive]
      @motivations = @user_motivation.positives
    elsif params[:negative]
      @motivations = @user_motivation.negatives
    elsif params[:to_do]
      @motivations = @user_motivation.to_dos
    elsif params[:want]
      @motivations = @user_motivation.wants
    end

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

    # ログインユーザーがidealテーブルとmission_statementのカラムを作成していない場合のアクセス制限
  def not_design_your_ideal_life!
    if !current_user.ideal.present? && !current_user.mission_statement.present?
      redirect_to welcome_path
    end
  end

  def motivation_params
    params.require(:motivation).permit(:emotion_stetas,:appetite,:memory)
  end

end