class Api::V1::ProgramTrackersController < Api::V1::BaseController
  before_action :authenticate_user!

  before_action :set_program_tracker, only: [ :show, :update, :destroy, :current_dwt, :five_day_array ]

  def index
    @program_trackers = policy_scope(ProgramTracker)
  end

  # program tracker show endpoint should return program_tracker, program, user, dwt data in order
  # Maybe does not need to return et data. Currently returns et data but no in the right order after an et is updated
  def show
    @daily_workout_trackers = @program_tracker.daily_workout_trackers
    @daily_workout_trackers = @daily_workout_trackers.sort { |a, b| a.id <=> b.id }
    @daily_workout_trackers.each do |dwt|
      @exercise_trackers = dwt.exercise_trackers.sort { |a, b| a.id <=> b.id }
    end
  end

  # should not need to use a update for Program_Trackers
  def update
    if @program_tracker.update(program_tracker_params)
      # render :show
    else
      render_error
    end
  end

  # When a program tracker is created, the nested dwts and ets are also created
  def create
    @program_tracker = ProgramTracker.new(program_tracker_params)
    @daily_workouts = @program_tracker.program.daily_workouts

    authorize @program_tracker
    authorize @daily_workouts
    if @program_tracker.save
      # iterate over the daily_workouts in the program_tracker.program
      # creates a dwt using the program_tracker.id, dw.id, and dw.day_number
      @daily_workouts.each do |dw|
        @daily_workout_tracker = DailyWorkoutTracker.new(program_tracker_id: @program_tracker.id, daily_workout_id: dw.id, dwt_day_number: dw.day_number)
        @daily_workout_tracker.save
        # iterates over each exercise in a daily_workout
        # creates an et using the dwt.id and exercise id
        dw.exercises.each do |exercise|
          @exercise_tracker = ExerciseTracker.new(exercise_id: exercise.id, daily_workout_tracker_id: @daily_workout_tracker.id, et_exercise_title: exercise.exercise_title)
          @exercise_tracker.save
        end
      end
      # render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @program_tracker.destroy
    head :no_content
  end


  def dwts
    dwts = @program_tracker.daily_workout_trackers
    dwts.sort { |a,b| a.id <=> b.id}
  end

  def last_day
    @program_tracker.program.number_of_days
  end

  def current_dwt
    set_current_dwt
  end

  def set_current_dwt
    if dwts.all? { |dwts| dwts.completed?}
      @current_dwt = dwts.max
    else
      @current_dwt = dwts.detect { |dwt| dwt.completed == false}
    end
    authorize @current_dwt
  end

  def five_day_array
    if set_current_dwt.dwt_day_number == last_day
      @five_dwts = dwts[(last_day-5)..(last_day-1)]
    elsif set_current_dwt.dwt_day_number > 3
      @five_dwts = dwts[(set_current_dwt.dwt_day_number-4)..(set_current_dwt.dwt_day_number)]
    elsif set_current_dwt.dwt_day_number == 1 || 2 || 3
      @five_dwts = dwts[0..4]
    end
  end

  private

  def set_program_tracker
    @program_tracker = ProgramTracker.find(params[:id])
    authorize @program_tracker
  end

  def program_tracker_params
    params.require(:program_tracker).permit(:program_id, :user_id, :current_day)
  end

  def render_error
    render json: { errors: @program_tracker.errors.full_messages },
      status: :unprocessable_entity
  end
end
