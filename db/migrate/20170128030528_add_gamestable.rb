class AddGamestable < ActiveRecord::Migration
  def change
	  create_table "games", force: :cascade do |t|
	    t.text "player",              null: false     # Bad i know but dont have the time to learn activerecord foreign keys
	    t.text "opponent",            null: false
	    t.integer "player_score"
	    t.integer "opponent_score"
	    t.datetime "game_date"
	  end
  end
end
