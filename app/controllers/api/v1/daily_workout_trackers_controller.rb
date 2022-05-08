class Api::V1::DailyWorkoutTrackersController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User #, except: [ :index, :show ]
  before_action :set_daily_workout_tracker, only: [ :show, :update, :destroy ]

  def index
    @daily_workout_trackers = policy_scope(DailyWorkoutTracker)
  end

  def show
  end

  def update
    if @daily_workout_tracker.update(daily_workout_tracker_params)
      render :show
    else
      render_error
    end
  end

  def create
    @daily_workout_tracker = DailyWorkoutTracker.new(daily_workout_tracker_params)
    authorize @daily_workout_tracker
    if @daily_workout_tracker.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @daily_workout_tracker.destroy
    head :no_content
  end

  private

  def set_daily_workout_tracker
    @daily_workout_tracker = DailyWorkoutTracker.find(params[:id])
    authorize @daily_workout_tracker
  end

  def daily_workout_tracker_params
    params.require(:daily_workout_tracker).permit(:dwt_check_in, :dwt_daily_challenge, :program_tracker_id, :daily_workout_id)
  end

  def render_error
    render json: { errors: @daily_workout_tracker.errors.full_messages },
      status: :unprocessable_entity
  end
end
