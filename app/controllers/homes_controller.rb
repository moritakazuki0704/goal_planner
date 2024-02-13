class HomesController < ApplicationController

  def top
  end

  def welcome
    @problem = Problem.where(user_id: current_user)
    @ideal = Ideal.where(user_id: current_user)
  end

end
