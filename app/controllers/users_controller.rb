class UsersController < ApplicationController
	include UsersHelper

	def index
		# Ajax request for the twitter stream
			@screen_name = params[:screen_name]
			@user = User.find_by(screen_name: @screen_name)

			if request.xhr?
				timestamp = params[:timestamp].to_f
				tweets_to_display =  UsersHelper.get_matching_tweets(@user, timestamp)
				render :json => tweets_to_display
			else

			# User information to be displayed
			user_information = get_user_info(@screen_name)
			@profile_picture = user_information[:profile_picture]
			@num_tweets = user_information[:num_tweets]
			@num_following = user_information[:num_following]
			if History.find_by(user_id: user_information[:user_id])
				@followers_count = History.where(user_id: user_information[:user_id]).last.followers_count
			end

			# Getting the graph data
			graph_data = UsersHelper.get_chart(@user)
			@xData = graph_data[0]
			@followers_record = graph_data[1]
			@favorites = graph_data[2]
			@data_changes = graph_data[3]
		end
	end

	def edit
		@user = User.find(session[:user_id])
	end

	def update
		@user = User.find(session[:user_id])
		@user.update_attributes(email: user_params[:email])
		email = @user.email #do not try to DRY this. 'email' needs to be passed in as a non-instance variable to sidekiq
		MailerWorker.perform_async(email)
		redirect_to users_path
	end


	def show
		requestor = User.find(session[:user_id])
		screen_name = params["screen_name"].downcase
		retrieved_information = Twitter.execute({user: requestor, request_type:"users/show.json?screen_name=#{screen_name}"})

		unless retrieved_information["screen_name"]
			flash[:notice] = "No twitter user matching this screen name"
			return redirect_to users_path(screen_name: requestor.screen_name)
		end

		requested_user = User.find_by(uid: retrieved_information["id"])
		requested_user ||= User.create(screen_name: screen_name, uid: retrieved_information["id"])
		requested_user.update_attributes(screen_name: screen_name) if requested_user.screen_name == nil

		if requested_user.histories.last == nil
			flash[:notice] = "We currently don't have enough information about this user, but we're working on it!"
			return redirect_to users_path(screen_name: requestor.screen_name)
		end

    redirect_to users_path(screen_name: screen_name)
	end

	def create
		screen_name = screen_name = params["screen_name"].downcase
		redirect_to users_path(screen_name: screen_name)
	end

	private
	def user_params
		params.require(:user).permit(:email)
	end
end

