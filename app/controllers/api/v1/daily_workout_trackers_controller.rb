class Api::V1::DailyWorkoutTrackersController < Api::V1::BaseController
  # acts_as_token_authentication_handler_for User #, except: [ :index, :show ]
  before_action :set_daily_workout_tracker, only: [ :show, :update, :destroy ]

  def index
    # this policy_scope limits the daily_workout_trackers to only the ones that belong to the program_tracker_id in the params
    @daily_workout_trackers = policy_scope(DailyWorkoutTracker.where(program_tracker_id: params[:program_tracker_id]))

    # need to sort dwts by id lowest to greatest
    @daily_workout_trackers = @daily_workout_trackers.sort { |a, b| a.id <=> b.id }
  end

  def show
  end

  def update
    if @daily_workout_tracker.update(daily_workout_tracker_params)
      # updates current day index
      add_one_to_program_tracker_current_day
      # updates the current dwt percent completed based on check_in, challenge, and exercises completed
      set_percentage_complete
      render :show
    else
      render_error
    end
  end

  # dwt create should not be used
  def create
    @daily_workout_tracker = DailyWorkoutTracker.new(daily_workout_tracker_params)
    authorize @daily_workout_tracker
    if @daily_workout_tracker.save
      render :show, status: :created
    else
      render_error
    end
  end

  # dwt destroy should not be used
  def destroy
    @daily_workout_tracker.destroy
    head :no_content
  end

  private

  def set_daily_workout_tracker
    @daily_workout_tracker = DailyWorkoutTracker.find(params[:id])
    authorize @daily_workout_tracker
  end

  # We probably do not need program_tracker_id and daily_workout_id
  def daily_workout_tracker_params
    params.require(:daily_workout_tracker).permit(:dwt_check_in, :dwt_daily_challenge, :completed, :exercises_completed, :program_tracker_id, :daily_workout_id)
  end

  def render_error
    render json: { errors: @daily_workout_tracker.errors.full_messages },
      status: :unprocessable_entity
  end

  # adds one to the program_tracker.current_day when a dwt is completed.true
  def add_one_to_program_tracker_current_day
    program_tracker = @daily_workout_tracker.program_tracker
    if @daily_workout_tracker.completed?
      current_day = program_tracker.current_day + 1
      program_tracker.update(current_day: current_day)
    end
  end

  # updates the dwt.percentage complete based on check_in, daily_challenge, and exercises
  def set_percentage_complete
    updated_percent = (dwt_check_in_submitted_percent + dwt_daily_challenge_submitted_percent + dwt_submitted_exercise_percent).rationalize
    @daily_workout_tracker.update(percentage_complete: updated_percent.rationalize)
  end

  # Checks if dwt.check_in true? If true sets dwt_check_in percent to 1/3...else sets it as 0
  def dwt_check_in_submitted_percent
    if @daily_workout_tracker.dwt_check_in?
      dwt_check_in_percent = Rational( dwt_number_of_exercises, (dwt_number_of_exercises * 3))
    else
      dwt_check_in_percent = 0
    end
    return dwt_check_in_percent
  end

  # Checks if dwt.daliy_challenge true? If true sets dwt_check_in percent to 1/3...else sets it as 0
  def dwt_daily_challenge_submitted_percent
    if @daily_workout_tracker.dwt_daily_challenge?
      dwt_daily_challenge_percent = Rational( dwt_number_of_exercises, (dwt_number_of_exercises * 3))
    else
      dwt_daily_challenge_percent = 0
    end
    return dwt_daily_challenge_percent
  end

  # Checks if dwt.exercises_completed true? If true sets dwt_check_in percent to 1/3...else sets it as 0
  def dwt_submitted_exercise_percent
    if @daily_workout_tracker.exercises_completed?
      dwt_exercises_percent = Rational( dwt_number_of_exercises, (dwt_number_of_exercises * 3))
    else
      dwt_exercises_percent = 0
    end
    return dwt_exercises_percent
  end

  # finds the number of exercises in a daily workout tracker.
  # This method is used in case we want to get a more accurate percentage completed.
  # For example completing the first exercise in a dwt will add 6%, completing the second exercise will addd another 6%...and so on
  def dwt_number_of_exercises
    @daily_workout_tracker.daily_workout.number_of_exercises
  end
end
