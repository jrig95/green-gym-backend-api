class Api::V1::RewardTrackersController < Api::V1::BaseController
  # acts_as_token_authentication_handler_for User #, except: [ :index, :show ]
  before_action :set_reward_tracker, only: [ :show]

  def show
  end

  def create
    @reward_tracker = RewardTracker.new(reward_tracker_params)
    authorize @reward_tracker
    if @reward_tracker.user.user_points >= @reward_tracker.reward.reward_points && @reward_tracker.save!
      deduct_user_points
      mail = RewardTrackerMailer.with(reward_tracker: @reward_tracker).redeem_reward
      mail.deliver_now
      render :show, status: :created
    else
      render_error
      # puts "reward points greater than your current points"
    end
  end

  private

  def deduct_user_points
    user = @reward_tracker.user
    reward_points = @reward_tracker.reward.reward_points
    updated_points = user.user_points - reward_points
    user.update(user_points: updated_points)
  end

  def set_reward_tracker
    @reward_tracker = RewardTracker.find(params[:id])
    authorize @reward_tracker
  end

  def reward_tracker_params
    params.require(:reward_tracker).permit(:reward_id, :user_id)
  end

  def render_error
    render json: { errors: @reward_tracker.errors.full_messages },
    status: :unprocessable_entity
  end

end
