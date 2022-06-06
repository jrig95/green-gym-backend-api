class Api::V1::DailyWorkoutTrackersController < Api::V1::BaseController
  # acts_as_token_authentication_handler_for User #, except: [ :index, :show ]
  before_action :set_daily_workout_tracker, only: [ :show, :update, :destroy ]

  def index
    @daily_workout_trackers = policy_scope(DailyWorkoutTracker.where(program_tracker_id: params[:program_tracker_id]))
    # puts @daily_workout_trackers.class
    @daily_workout_trackers = @daily_workout_trackers.sort { |a, b| a.id <=> b.id }

    # need to sort dwts by id lowest to greatest
  end

  def show
    # daily_workout_trackers = @daily_workout_tracker.program_tracker.daily_workout_trackers
    # daily_workout_trackers.each do |dwt|
    #   dwt.daily_workout.day_number
    # end

    # current_day = @daily_workout_tracker
    # current_day_number = @daily_workout_tracker.daily_workout.day_number
    # last_day = current_day.daily_workout.program.number_of_days

    # @five_dwts = []
    # if current_day.daily_workout.day_number == last_day
    #   @five_dwts = daily_workout_trackers[(last_day - 5)..(last_day - 1)]
    # elsif current_day.daily_workout.day_number > 3
    #   @five_dwts = daily_workout_trackers[(current_day_number - 4)..current_day_number]
    # elsif current_day.daily_workout.day_number == 1 || 2 || 3
    #  @five_dwts = daily_workout_trackers[0..4]
    # end
  end

  def update
    if @daily_workout_tracker.update(daily_workout_tracker_params)
      add_one_to_program_tracker_current_day
      set_percentage_complete
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
    params.require(:daily_workout_tracker).permit(:dwt_check_in, :dwt_daily_challenge, :completed, :exercises_completed, :program_tracker_id, :daily_workout_id)
  end

  def render_error
    render json: { errors: @daily_workout_tracker.errors.full_messages },
      status: :unprocessable_entity
  end

  def add_one_to_program_tracker_current_day
    program_tracker = @daily_workout_tracker.program_tracker
    if @daily_workout_tracker.completed?
      current_day = program_tracker.current_day + 1
      program_tracker.update(current_day: current_day)
    end
  end

  def set_percentage_complete
    updated_percent = (dwt_check_in_submitted_percent + dwt_daily_challenge_submitted_percent + dwt_submitted_exercise_percent).rationalize
    @daily_workout_tracker.update(percentage_complete: updated_percent.rationalize)
  end

  def dwt_check_in_submitted_percent
    if @daily_workout_tracker.dwt_check_in?
      dwt_check_in_percent = Rational( dwt_number_of_exercises, (dwt_number_of_exercises * 3))
    else
      dwt_check_in_percent = 0
    end
    return dwt_check_in_percent
  end

  def dwt_daily_challenge_submitted_percent
    if @daily_workout_tracker.dwt_daily_challenge?
      dwt_daily_challenge_percent = Rational( dwt_number_of_exercises, (dwt_number_of_exercises * 3))
    else
      dwt_daily_challenge_percent = 0
    end
    return dwt_daily_challenge_percent
  end

  def dwt_submitted_exercise_percent
    if @daily_workout_tracker.exercises_completed?
      dwt_exercises_percent = Rational( dwt_number_of_exercises, (dwt_number_of_exercises * 3))
    else
      dwt_exercises_percent = 0
    end
    return dwt_exercises_percent
  end

  # def dwt_submitted_exercise_percent
  #   submitted_exercise_trackers = []
  #   @daily_workout_tracker.exercise_trackers.each  do |exercise_tracker|
  #     submitted_exercise_trackers << exercise_tracker if exercise_tracker.submitted?
  #   end
  #   dwt_exercise_percent = Rational(submitted_exercise_trackers.length, (dwt_number_of_exercises))
  #   return ((dwt_exercise_percent)/(3)).rationalize
  # end

  # def dwt_submitted_exercise_percent
  #   submitted_exercise_trackers = []
  #   @daily_workout_tracker.exercise_trackers.each do |exercise_tracker|
  #     submitted_exercise_trackers << exercise_tracker.submitted
  #   end
  #   if submitted_exercise_trackers.any?
  #     dwt_exercise_percent = Rational(dwt_number_of_exercises, (dwt_number_of_exercises * 3))
  #   else
  #     dwt_exercise_percent = 0
  #   end
  #   return dwt_exercise_percent
  # end


  def dwt_number_of_exercises
    @daily_workout_tracker.daily_workout.number_of_exercises
  end

end
