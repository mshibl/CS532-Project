class StalkerWorker
	include Sidekiq::Worker
	def perform
		response = Twitter.app_request("users/lookup.json?screen_name=katyperry%2Cjustinbieber%2CBarackObama%2Ctaylorswift13%2Cladygaga%2Crihanna%2C%20jtimberlake%2C%20TheEllenShow%2C%20britneyspears%2C%20Cristiano%2C%20KimKardashian%2C%20JLO%2C%20shakira%2C%20selenagomez%2C%20jimmyfallon%2C%20onedirection%2C%20onedirection%2C%20pitbull%2C%20MileyCyrus%2C%20KevinHart4real%2C%20Eminem%2C%20NICKIMINAJ%2C%20Beyonc%C3%A9%2C%20ParisHilton%2C%20kanyewest%2C%20SnoopDogg%2C%20maroon5%2CrealDonaldTrump%2Cdevbootcamp%2CHackReactor%2Cappacademyio%2Cshereef%2Camgando")


		response.each do |tracked_person|
			user = User.find_by(uid: tracked_person["id"])
			user ||= User.create(uid: tracked_person["id"])
			id = user.id
			
			History.create(user_id: id, followers_count: tracked_person["followers_count"])
		end
	end
end

