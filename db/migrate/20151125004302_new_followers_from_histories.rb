class NewFollowersFromHistories < ActiveRecord::Migration
  def change
  	remove_column :histories, :new_followers, :integer
  end
end
