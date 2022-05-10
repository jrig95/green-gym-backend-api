class Api::V1::ExercisesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User #, except: [ :index, :show ]
  before_action :set_exercise, only: [ :show,:update, :destroy ]

  def index
    @exercises = policy_scope(Exercise)
  end

def show
end

  def update
    if @exercise.update(exercise_params)
      render :show
    else
      render_error
    end
  end

  def create
    @exercise = Exercise.new(exercise_params)
    @daily_workout = @exercise.daily_workout
    authorize @exercise
    if @exercise.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @exercise.destroy
    head :no_content
  end

   private

  def set_exercise
    @exercise = Exercise.find(params[:id])
    @daily_workout = @exercise.daily_workout
    authorize @exercise
  end

  def exercise_params
    params.require(:exercise).permit( :exercise_title, :library_item_id, :daily_workout_id, :exercise_question, :exercise_work_time, :exercise_rest_time, :calories_per_exercise)
  end

  def render_error
    render json: { errors: @exercise.errors.full_messages },
      status: :unprocessable_entity
  end
end
