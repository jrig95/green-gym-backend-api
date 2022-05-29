class Api::V1::ProgramTrackersController < Api::V1::BaseController
  # acts_as_token_authentication_handler_for User #, except: [ :index, :show ]
  before_action :set_program_tracker, only: [ :show, :update, :destroy, :current_dwt, :five_day_array ]

  def index
    @program_trackers = policy_scope(ProgramTracker)
  end

  def show
  end

  def update
    if @program_tracker.update(program_tracker_params)
      render :show
    else
      render_error
    end
  end

  def create
    @program_tracker = ProgramTracker.new(program_tracker_params)
    @daily_workouts = @program_tracker.program.daily_workouts

    authorize @program_tracker
    authorize @daily_workouts
    if @program_tracker.save

      @daily_workouts.each do |dw|
        @daily_workout_tracker = DailyWorkoutTracker.new(program_tracker_id: @program_tracker.id, daily_workout_id: dw.id, dwt_day_number: dw.day_number)
        @daily_workout_tracker.save

        dw.exercises.each do |exercise|
          @exercise_tracker = ExerciseTracker.new(exercise_id: exercise.id, daily_workout_tracker_id: @daily_workout_tracker.id, et_exercise_title: exercise.exercise_title)
          @exercise_tracker.save
        end
      end
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @program_tracker.destroy
    head :no_content
  end

  def current_dwt
    set_current_dwt
  end

  def five_day_array
    # @five_dwts = []
    if set_current_dwt.dwt_day_number == last_day
      # dwts.sort { |a,b| a.id <=> b.id}
      @five_dwts = dwts[(last_day-5)..(last_day-1)]
    elsif set_current_dwt.dwt_day_number > 3
      # dwts.sort { |a,b| a.id <=> b.id}
      @five_dwts = dwts[(current_day_number-4)..(current_day_number)]
    elsif set_current_dwt.dwt_day_number == 1 || 2 || 3
      # dwts.sort { |a,b| a.id <=> b.id}
      @five_dwts = dwts[0..4]
    end
  end

  private

  def set_program_tracker
    @program_tracker = ProgramTracker.find(params[:id])
    authorize @program_tracker
  end

  def program_tracker_params
    params.require(:program_tracker).permit(:program_id, :user_id)
  end

  def render_error
    render json: { errors: @program_tracker.errors.full_messages },
      status: :unprocessable_entity
  end

  def set_current_dwt
    if dwts.all? { |dwt| dwt.completed?}
      @current_dwt = dwts.where(id: dwts.id.max)
    else
      @current_dwt = dwts.detect { |dwt| dwt.completed == false}
      authorize @current_dwt
    end
  end

  def dwts
    dwts = @program_tracker.daily_workout_trackers
    dwts.sort { |a,b| a.id <=> b.id}
  end

  def current_day_number
    set_current_dwt.dwt_day_number
  end

  def last_day
    @program_tracker.program.number_of_days
  end
end
