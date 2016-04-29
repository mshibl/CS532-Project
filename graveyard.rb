   # logic for level2/3 --> didin't work 

  # def self.get_change_in_followers(user_id)
  #   user = User.find(user_id)
    
  #   # Set the refernce follower that will be used to find number of unfollowers
  #   offset_counter = 0
  #   last_follower_id = 0
  #   last_follower_uid = 0
  #   loop do 
  #     last_follower_id = user.relationships.offset(offset_counter).last.follower_id
  #     last_follower_uid = User.find(last_follower_id).uid
  #     # last_follower_id = user.followers.offset(offset_counter).last.uid
  #     last_follower_friendship_status = Twitter.execute({user: user, request_type: "friendships/show.json?source_id=#{user.uid}&target_id=#{last_follower_uid}"})["relationship"]["source"]["followed_by"]
  #     break if last_follower_friendship_status == true
  #       # Deletes the last person from the list
  #       relation = user.relationships.last
  #       relation.delete
  #       ##################################
  #     # offset_counter += 1
  #   end

  #   # Getting the net change in number of followers
  #   last_followers_count = History.where(user_id: user_id).order(:created_at).last.followers_count
  #   new_followers_count = Twitter.execute({user: user, request_type: "users/show.json?screen_name=#{user.screen_name}"})["followers_count"]
  #   net_change = new_followers_count - last_followers_count


  #   # Get the latest updated list of followers ids
  #   cursor = -1
  #   verified_new_followers = []
  #   ordered_followers = []
  #   loop do
  #     followers_list = Twitter.execute({user: user, request_type: "followers/ids.json?cursor=#{cursor}&screen_name=#{user.screen_name}"})
  #     ordered_followers = followers_list["ids"].reverse
  #     break if ordered_followers.include?(last_follower_uid.to_i)
  #     verified_new_followers << ordered_followers
  #     cursor = followers_list["next_cursor"]
  #   end

  #   # Get the verified number of new followers
  #   last_follower_index = ordered_followers.index(last_follower_uid.to_i)
  #   unless ordered_followers[(last_follower_index+1)..-1].empty?
  #     verified_new_followers << ordered_followers[(last_follower_index+1)..-1]
  #   end
  #   verified_new_followers.flatten!
  #   verified_new_followers_count = verified_new_followers.count

  #   # Calculate the number of unfollowers
  #   unfollowers_count = verified_new_followers_count - net_change

  #   # Add new followers to users table, and create relationships
  #   verified_new_followers.each do |new_follower_id|
  #     follower = User.find_by(uid: new_follower_id)
  #     follower ||= User.create(uid: new_follower_id)
  #     Relationship.create(user_id: user_id, follower_id: follower.id)
  #   end

  #   # <level-3> Remove unfollowers reltaionships with user
  #     # check the follower count
  #     # divide follower count by 100 + 1
  #     # start a .times loop that makes an api request
  #     # the api request takes the list of ordered followers 100 at a time
  #     # loop over the result to find people who unfollowed

  #   #adding count of unfollowers and followers to hash
  #   change_in_followers = {
  #     new_followers: verified_new_followers_count,
  #     unfollowers: unfollowers_count
  #   }
  # end