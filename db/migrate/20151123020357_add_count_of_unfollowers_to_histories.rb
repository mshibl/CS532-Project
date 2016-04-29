class AddCountOfUnfollowersToHistories < ActiveRecord::Migration
  def change
    add_column :histories, :unfollowers, :integer
  end
end