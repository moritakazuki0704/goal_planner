class UsersController < ApplicationController

  before_action :keyword_created_user!,only: [:mission_statement_new,:mission_statement_confirm,:mission_statement_update]
  before_action :user_current,except: [:withdrawal]

  def keyword_new
  end

  def keyword_confirm
    session[:first_keyword] = user_params[:first_keyword]
    session[:second_keyword] = user_params[:second_keyword]
    session[:third_keyword] = user_params[:third_keyword]
    session[:fourth_keyword] = user_params[:fourth_keyword]
    session[:fifth_keyword] = user_params[:fifth_keyword]
    session[:sixth_keyword] = user_params[:sixth_keyword]
    session[:seventh_keyword] = user_params[:seventh_keyword]
    session[:eighth_keyword] = user_params[:eighth_keyword]
    session[:ninth_keyword] = user_params[:ninth_keyword]
    session[:tenth_keyword] = user_params[:tenth_keyword]
  end

  def keyword_update
    @user.update(
      first_keyword: session[:first_keyword],
      second_keyword: session[:second_keyword],
      third_keyword: session[:third_keyword],
      fourth_keyword: session[:fourth_keyword],
      fifth_keyword: session[:fifth_keyword],
      sixth_keyword: session[:sixth_keyword],
      seventh_keyword: session[:seventh_keyword],
      eighth_keyword: session[:eighth_keyword],
      ninth_keyword: session[:ninth_keyword],
      tenth_keyword: session[:tenth_keyword],
      )
    redirect_to mission_statement_new_user_path
  end

  def mission_statement_new
  end

  def mission_statement_confirm
    session[:mission_statement] = user_params[:mission_statement]
    session[:mission_statement_detail] = user_params[:mission_statement_detail]
  end

  def mission_statement_update
    @user.update(
      mission_statement: session[:mission_statement],
      mission_statement_detail: session[:mission_statement_detail],
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
    if !current_user.tenth_keyword.present?
      redirect_to welcome_path
    end
  end

  def user_params
    params.require(:user).permit(:first_keyword,:second_keyword,:third_keyword,:fourth_keyword,:fifth_keyword,:sixth_keyword,:seventh_keyword,:eighth_keyword,:ninth_keyword,:tenth_keyword,
                                 :mission_statement,:mission_statement_detail)
  end

end