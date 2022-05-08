class Api::V1::DailyWorkoutsController < Api::V1::BaseController

  acts_as_token_authentication_handler_for User #, except: [ :index, :show ]
  before_action :set_daily_workout, only: [ :show,:update, :destroy ]

  def index
    @daily_workouts = policy_scope(DailyWorkout)
  end

  def show
  end

  def update
    if @daily_workout.update(daily_workout_params)
      render :show
    else
      render_error
    end
  end

  def create
    @daily_workout = DailyWorkout.new(daily_workout_params)
    # @program = @daily_workout.program
      # Creates a ProgramTracker between the admin and the newly created program
      # @program.users << User.where(admin: true)
    authorize @daily_workout
    if @daily_workout.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @daily_workout.destroy
    head :no_content
  end

  private

  def set_daily_workout
    @daily_workout = DailyWorkout.find(params[:id])
    @program = @daily_workout.program
    # @program = Program.where(id: params[:daily_workout][:program_id])
    authorize @daily_workout
  end

  def daily_workout_params
    params.require(:daily_workout).permit(:program_id, :day_number, :daily_challenge_description, :daily_challenge_title, :number_of_exercises)
  end

  def render_error
    render json: { errors: @daily_workout.errors.full_messages },
      status: :unprocessable_entity
  end
end
