class MailerWorker
  include Sidekiq::Worker
  def perform(email)
    UserMailer.send_report_card(email).deliver_now
  end
end
