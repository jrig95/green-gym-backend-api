class Api::V1::ExerciseOverviewsController < Api::V1::BaseController

# acts_as_token_authentication_handler_for User, except: [ :index, :show ]
before_action :set_exercise_overview, only: [ :show,:update, :destroy ]

def index
  @exercise_overviews = policy_scope(ExerciseOverview.where(daily_workout_id: params[:daily_workout_id]))
  # @daily_workouts = policy_scope(DailyWorkout.where(program_id: params[:program_id]))

end

def show
end

  def update
    if @exercise_overview.update(exercise_overview_params)
      render :show
    else
      render_error
    end
  end

  def create
    @exercise_overview = ExerciseOverview.new(exercise_overview_params)
    @daily_workout = @exercise_overview.daily_workout
    authorize @exercise_overview
    if @exercise_overview.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @exercise_overview.destroy
    head :no_content
  end

   private

  def set_exercise_overview
    @exercise_overview = ExerciseOverview.find(params[:id])
    @daily_workout = @exercise_overview.daily_workout
    authorize @exercise_overview
  end

  def exercise_overview_params
    params.require(:exercise_overview).permit( :daily_workout_id, :overview_exercise_title, :number_of_sets)
  end

  def render_error
    render json: { errors: @exercise_overview.errors.full_messages },
      status: :unprocessable_entity
  end
end
