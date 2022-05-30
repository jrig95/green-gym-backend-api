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
      # add_submited_to_dwt_percent
      render :show
    else
      render_error
    end
  end

  def create
    @exercise_tracker = ExerciseTracker.new(exercise_tracker_params)
    @exercise_tracker.update(et_exercise_title: @exercise_tracker.exercise.exercise_title)
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
      updated_points = user.user_points + exercise_calories
      updated_calories = user.user_total_calories + exercise_calories
      user.update(user_total_calories: updated_calories, user_points: updated_points)
    end
  end

  # def add_submited_to_dwt_percent
  #   @daily_workout_tracker = @exercise_tracker.daily_workout_tracker
  #   number_of_total_exercises = @daily_workout_tracker.daily_workout.number_of_exercises
  #   current_dwt_percent_completed = @exercise_tracker.daily_workout_tracker.percentage_complete
  #   updated_dwt_percent_completed = ((1.0/number_of_total_exercises.to_f)/3) + current_dwt_percent_completed
  #   @daily_workout_tracker.update(percentage_complete: updated_dwt_percent_completed.round(2))
  # end

  def set_exercise_tracker
    @exercise_tracker = ExerciseTracker.find(params[:id])
    authorize @exercise_tracker
  end

  def exercise_tracker_params
    params.require(:exercise_tracker).permit(:number_of_reps, :daily_workout_tracker_id, :exercise_id, :submitted)
  end

  def render_error
    render json: { errors: @exercise_tracker.errors.full_messages },
      status: :unprocessable_entity
  end
end
