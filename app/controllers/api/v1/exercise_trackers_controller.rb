class Api::V1::ExerciseTrackersController < Api::V1::BaseController
  # acts_as_token_authentication_handler_for User #, except: [ :index, :show ]
  before_action :set_exercise_tracker, only: [ :show, :update, :destroy ]

  def index
    @exercise_trackers = policy_scope(ExerciseTracker.where(daily_workout_tracker_id: params[:daily_workout_tracker_id]))
    # @daily_workouts = policy_scope(DailyWorkout.where(program_id: params[:program_id]))

  end

  def show
  end

  def update
    if @exercise_tracker.update(exercise_tracker_params)
      render :show
    else
      render_error
    end
  end

  def create
    @exercise_tracker = ExerciseTracker.new(exercise_tracker_params)
    authorize @exercise_tracker
    if @exercise_tracker.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @exercise_tracker.destroy
    head :no_content
  end

  private

  def set_exercise_tracker
    @exercise_tracker = ExerciseTracker.find(params[:id])
    authorize @exercise_tracker
  end

  def exercise_tracker_params
    params.require(:exercise_tracker).permit(:number_of_reps, :exercise_id, :daily_workout_tracker_id)
  end

  def render_error
    render json: { errors: @exercise_tracker.errors.full_messages },
      status: :unprocessable_entity
  end
end
