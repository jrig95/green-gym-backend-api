class RewardTrackerMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reward_tracker_mailer.redeem_reward.subject
  #
  def redeem_reward
    @reward_tracker = params[:reward_tracker] # Instance variable => available in view
    @reward = @reward_tracker.reward
    @user = @reward_tracker.user
    mail(to: ['darren@relabs.co', @user.email], subject: 'User has redeemed a reward')

    # This will render a view in `app/views/user_mailer`!
  end
end
