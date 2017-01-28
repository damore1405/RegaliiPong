class HomeController < ApplicationController
  def index
  	# Grab Leaderboard Info, prepend rank index in view
  	leaderboard = []
  	User.all.collect.each do |user|
  		# for each user get the sum total of their scores
  		leaderboard.append ([
  			user, 
  			Game.where(player: user.email).sum(:player_score) + Game.where(opponent: user.email).sum(:opponent_score), 
  			Game.where(player: user.email).count()
  			])

  	# this is expensive, the best case a heap would be used instead of sorting the whole thing
  	# but it looks like ruby doesnt have it in the stdlib, sort the list by user with top score instead
  	leaderboard.sort_by! { |leader| [leader[1]] }
  	@leaderboard = leaderboard.reverse
  	end
  end

  def history
  	#Collect rows from the Game table in which the player was the current user
  	@player_history = Game.where(player: current_user.email).order(game_date: :desc)

  end

  def log
  	if request.method == "POST"
  		#save the new game after a request has been made
  		game = Game.new
  		game.player = current_user.email
	  	game.opponent = params[:user][:opponent_name]
	  	game.game_date = params[:Game][:game_date]
	  	game.player_score = params[:PlayerScore]
	  	game.opponent_score = params[:OpponentScore]
	  	game.save()
	  	return
	end

  end

end

