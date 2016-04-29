class AddCountOfFollowersToHistories < ActiveRecord::Migration
  def change
    add_column :histories, :new_followers, :integer
  end
end