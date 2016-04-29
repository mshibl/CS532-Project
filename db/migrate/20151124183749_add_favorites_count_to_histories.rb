class AddFavoritesCountToHistories < ActiveRecord::Migration
  def change
  	add_column :histories, :favorites_count, :integer
  end
end
