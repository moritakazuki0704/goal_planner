class UsersController < ApplicationController

  before_action :keyword_created_user!,only: [:mission_statement_new,:mission_statement_confirm,:mission_statement_update]
  before_action :user_current,except: [:withdrawal]

  def keyword_new
  end

  def keyword_confirm
    session[:keyword_1] = user_params[:keyword_1]
    session[:keyword_2] = user_params[:keyword_2]
    session[:keyword_3] = user_params[:keyword_3]
    session[:keyword_4] = user_params[:keyword_4]
    session[:keyword_5] = user_params[:keyword_5]
    session[:keyword_6] = user_params[:keyword_6]
    session[:keyword_7] = user_params[:keyword_7]
    session[:keyword_8] = user_params[:keyword_8]
    session[:keyword_9] = user_params[:keyword_9]
    session[:keyword_10] = user_params[:keyword_10]
  end

  def keyword_update
    @user.update(
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
      )
    redirect_to mission_statement_new_user_path
  end

  def mission_statement_new
  end

  def mission_statement_confirm
    session[:mission_statement] = user_params[:mission_statement]
    session[:mission_detail] = user_params[:mission_detail]
  end

  def mission_statement_update
    @user.update(
      mission_statement: session[:mission_statement],
      mission_detail: session[:mission_detail],
      )
    redirect_to new_problem_path
  end

  def withdrawal
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def user_current
    @user = current_user
  end

  # ログインユーザーがmission_statementのカラムを作成している場合のアクセス制限
  def keyword_created_user!
    if current_user.keyword_10.present?
      redirect_to welcome_path
    end
  end

  def user_params
    params.require(:user).permit(:keyword_1,:keyword_2,:keyword_3,:keyword_4,:keyword_5,:keyword_6,:keyword_7,:keyword_8,:keyword_9,:keyword_10,
                                 :mission_statement,:mission_statement_detail)
  end

end
