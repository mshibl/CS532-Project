class AddRetweetCountToHistories < ActiveRecord::Migration
  def change
  	add_column :histories, :retweet_count, :integer
  end
end
