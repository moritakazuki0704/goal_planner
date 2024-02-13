class UsersController < ApplicationController

  before_action :design_your_ideal_life!,except: [:withdrawal,:destroy]
  before_action :ideal_uncreated_user!

  def new
    @user = current_user
  end

  def confirm
    session[:mission_statement] = user_params[:mission_statement]
    session[:mission_detail] = user_params[:mission_detail]
    @user = current_user
  end

  def update
    current_user.update(
      mission_statement: session[:mission_statement],
      mission_detail: session[:mission_detail],
      )
    redirect_to new_problem_path
  end

  def withdrawal
  end

  def destroy
    current_user.destroy
    redirect_to root_path
  end

  private

  # ログインユーザーがidealテーブルとmission_statementのカラムを作成していない場合のアクセス制限
  def design_your_ideal_life!
    if current_user.ideal.present? && current_user.mission_statement.present?
      redirect_to welcome_path
    end
  end

  # ログインユーザーがidealテーブルを作成していない場合のアクセス制限
  def ideal_uncreated_user!
    if !current_user.ideal.present?
      redirect_to welcome_path
    end
  end

  def user_params
    params.require(:user).permit(:mission_statement,:mission_detail)
  end

end
