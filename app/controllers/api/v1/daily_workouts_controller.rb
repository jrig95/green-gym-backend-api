class Api::V1::DailyWorkoutsController < Api::V1::BaseController
  before_action :authenticate_user!, except: [:last_workout]
  # acts_as_token_authentication_handler_for User  #, except: [ :index, :show ]
  before_action :set_daily_workout, only: [ :show,:update, :destroy, :exercises ]

  def index
    @daily_workouts = policy_scope(DailyWorkout.where(program_id: params[:program_id]))
  end

  def show
    @exercise_overviews = @daily_workout.exercise_overviews.sort { |a, b| a.id <=> b.id }
    @exercises = @daily_workout.exercises.sort { |a, b| a.id <=> b.id }
  end

  def update
    if @daily_workout.update(daily_workout_params)
      # render :show
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

  def last_workout
    @daily_workout = DailyWorkout.last
    authorize @daily_workout
  end

  private

  def set_daily_workout
    @daily_workout = DailyWorkout.find(params[:id])
    @program = @daily_workout.program
    authorize @daily_workout
  end

  def daily_workout_params
    params.require(:daily_workout).permit(:program_id, :day_number, :daily_challenge_description, :daily_challenge_title, :number_of_exercises, :description, :program_library_item_id)
  end

  def render_error
    render json: { errors: @daily_workout.errors.full_messages },
      status: :unprocessable_entity
  end
end
