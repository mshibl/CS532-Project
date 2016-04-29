require 'rest_client'

# The consumer key identifies the application making the request.
CONSUMER_KEY = OAuth::Consumer.new(
  Rails.application.secrets.twitter_api_key,
  Rails.application.secrets.twitter_api_secret)

# All requests will be sent to this server.
  BASE_URL = "https://api.twitter.com"

class Twitter
  # require 'rest_client'

  def self.create_access_token(auth_token, auth_secret) # The access token identifies the user making the request.
    @access_token = OAuth::Token.new(auth_token, auth_secret)
  end

  def self.set_http_request(api_call) # Set up Net::HTTP to use SSL, which is required by Twitter.
    http = Net::HTTP.new api_call.host, api_call.port
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    return http
  end

  def self.authorize_request(http, access_token, api_call) # Build the request and authorize it with OAuth.
    request = Net::HTTP::Get.new api_call.request_uri
    request.oauth!(http, CONSUMER_KEY, access_token)
    return request
  end

  def self.get_response(auth_token, auth_secret, address)
    access_token = Twitter.create_access_token(auth_token, auth_secret)
    http = Twitter.set_http_request(address)
    authorized_request = Twitter.authorize_request(http, access_token, address)
    response = http.request(authorized_request) # Issue the request and store the response.
    result = JSON.parse(response.body)
  end

  #  Twitter.execute allows us to make api request on behalf of certain users. options hash = {user: <user>, request_type: <request>}
  def self.execute(options)
    address = URI("#{BASE_URL}/1.1/#{options[:request_type]}") # The verify credentials endpoint returns a 200 status if the request is signed correctly.
    user = options[:user]
    auth_token = user.auth_token
    auth_secret = user.auth_secret
    Twitter.get_response(auth_token, auth_secret, address)
  end

  # Twitter.app_request allows us to make api requests using our own app's limit instead of any user's limit
  def self.app_request(request_type)
    address = "#{BASE_URL}/1.1/#{request_type}"
    bearer_token = Rails.application.secrets.bearer_token

    response = RestClient.get address, {:Authorization => "Bearer #{bearer_token}"}
    JSON.parse(response.body)
  end

  # Get the latest full list of followers from Twitter (up to 75,000 followers only)
  def self.get_full_followers_list(user_id,followers_count)
    user = User.find(user_id)
    num_of_pages = ((followers_count / 5000) + 1)
    cursor = -1
    ordered_followers = []

    num_of_pages.times do
      followers_list = Twitter.execute({user: user, request_type: "followers/ids.json?stringify_ids=true&cursor=#{cursor}&user_id=#{user.uid}"})
      ordered_followers << followers_list["ids"].reverse
      cursor = followers_list["next_cursor"]
    end
    return ordered_followers.flatten!
  end

  # Get a hash of followers and unfollowers since the last recorded history of a given user
  def self.get_followers_and_unfollowers(user_id,followers_count)
    user = User.find(user_id)

    old_list_of_followers = user.followers.select(:uid).map(&:uid)
    new_list_of_followers = Twitter.get_full_followers_list(user.id,followers_count)

    followership_info = {
      new_followers: (new_list_of_followers - old_list_of_followers),
      unfollowers: (old_list_of_followers - new_list_of_followers)
    }
  end

end
