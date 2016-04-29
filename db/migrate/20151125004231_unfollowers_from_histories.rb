class UnfollowersFromHistories < ActiveRecord::Migration
  def change
  	remove_column :histories, :unfollowers, :integer
  end
end
