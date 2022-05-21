class Api::V1::DailyWorkoutsController < Api::V1::BaseController

  # acts_as_token_authentication_handler_for User  #, except: [ :index, :show ]
  before_action :set_daily_workout, only: [ :show,:update, :destroy, :exercises ]

  def index
    @daily_workouts = policy_scope(DailyWorkout.where(program_id: params[:program_id]))
  end

  def show
    # curent day = @daily_workout.day_number

    @exercises = Exercise.where(daily_workout_id: @daily_workout.id)
    puts "Here is the exercises array"

    @library_items = []

    @exercises.each do |exercise|
      @library_items << exercise.library_item
    end

    @daily_workout
    #
    # @daily_workout.program_id == params[:program_id].to_i
    # [] = array daily workouts
    # find dw after current program.daily_workout(where: daynumber == daily_workout.daynumber + 1)

    # if there are no daily workouts before, find current dw, and next 4
    #
  end

  def exercises
    @exercises = Exercise.where(daily_workout_id: @daily_workout.id)
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
