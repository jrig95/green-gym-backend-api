# Preview all emails at http://localhost:3000/rails/mailers/reward_tracker_mailer
class RewardTrackerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reward_tracker_mailer/redeem_reward
  def redeem_reward
    reward_tracker = RewardTracker.last
    RewardTrackerMailer.with(reward_tracker: reward_tracker).redeem_reward
  end

end
