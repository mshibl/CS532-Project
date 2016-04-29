class UpdateFollowersListWorker
	include Sidekiq::Worker
	def perform(user_id,followers_count)
		followership_info = Twitter.get_followers_and_unfollowers(user_id,followers_count)
    event_id = History.where(user_id: user_id).order(:created_at).last.id

		# Add new followers
		followership_info[:new_followers].each do |uid|
			follower = User.find_by(uid: uid)
    	follower ||= User.create(uid: uid)
      Relationship.where(user_id: user_id).find_by(follower_id: follower.id) || Relationship.create(user_id: user_id, follower_id: follower.id)
      Follow.create(follower_id: follower.id, follow_event_id: event_id)
		end

		# Delete unfollowers
		followership_info[:unfollowers].each do |uid|
			unfollower = User.find_by(uid: uid)
      Relationship.where(user_id: user_id).find_by(follower_id: unfollower.id).delete
      Unfollow.create(unfollower_id: unfollower.id, unfollow_event_id: event_id)
		end
	end
end