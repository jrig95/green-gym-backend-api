require "test_helper"

class RewardTrackerMailerTest < ActionMailer::TestCase
  test "redeem_reward" do
    mail = RewardTrackerMailer.redeem_reward
    assert_equal "Redeem reward", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
