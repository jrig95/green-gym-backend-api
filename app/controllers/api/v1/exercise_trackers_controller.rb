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
      add_exercise_calories_to_user
      render :show
    else
      render_error
    end
  end

  # adding calories to a user's calories
  # 1) add a submit boolean to excercise tracker default false
  # 2) define a private method that finds e_tracker.exercise.calories_per_exercise, and finds a user's total points, then adds them together.
  # 3) when that e_tracker is updated with sumbited:true run method


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

  def add_exercise_calories_to_user
    user = @exercise_tracker.daily_workout_tracker.program_tracker.user
    exercise_calories = @exercise_tracker.exercise.calories_per_exercise
    if @exercise_tracker.submitted?
      updated_calories = user.user_total_calories + exercise_calories
      user.update(user_total_calories: updated_calories)
    end
  end

  def set_exercise_tracker
    @exercise_tracker = ExerciseTracker.find(params[:id])
    authorize @exercise_tracker
  end

  def exercise_tracker_params
    params.require(:exercise_tracker).permit(:number_of_reps, :submitted)
  end

  def render_error
    render json: { errors: @exercise_tracker.errors.full_messages },
      status: :unprocessable_entity
  end
end
