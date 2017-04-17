class HomeController < ApplicationController
  def index
    @ranking = Ranking.all
  end

  def history
    @games = Game.my_games(current_user)
  end

  def log
    @game = Game.new
    @users = User.where.not(id: current_user.id)
  end
end
