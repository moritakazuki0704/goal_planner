class ApplicationController < ActionController::Base

  before_action :authenticate_user!,except:[:top]
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後のパス
  def after_sign_in_path_for(resource)

    # ログインユーザーがproblemテーブルを作成していれば
    if !current_user.problems.present?
      welcome_path

    # ログインユーザーがproblemテーブルを作成している場合
    else
      schedules_path
    end
  end

  # 新規作成後のパス
  def after_sign_up_path_for(resource)
    welcome_path
  end

  # ログアウト後のパス
  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:planner_name,:email] )
  end

end
