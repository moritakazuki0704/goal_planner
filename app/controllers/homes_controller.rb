class HomesController < ApplicationController

  def top
  end

  def welcome
    @problem = current_user.problems
    @user = current_user
  end

end
