# class Api::V1::UsersController < ApplicationController
class Api::V1::UsersController < Api::V1::BaseController
  # should use the authenticate_user! for JWT
  # before_action :authenticate_user!

  # acts_as_token_authentication_handler_for User
  before_action :set_user, only: [ :show,:update ]

  def index
    if params[:query].present?
      sql_query = " \
        email ILIKE :query \
        OR first_name ILIKE :query \
        OR last_name ILIKE :query \
        OR user_company ILIKE :query \
        OR user_fitness_level ILIKE :query \
      "
      @users = policy_scope(User.where(sql_query, query: "%#{params[:query]}%"))
    else
      @users = policy_scope(User)
    end
  end

  def show
    @program_trackers = @user.program_trackers
    @program_trackers.each do |program_tracker|
      @daily_workout_trackers = program_tracker.daily_workout_trackers.sort { |a, b| a.id <=> b.id }
      @daily_workout_trackers.each do |dwt|
        @exercise_trackers = dwt.exercise_trackers.sort { |a, b| a.id <=> b.id }
        dwt.exercise_trackers << @exercise_trackers
      end
    end
  end

  def update
    if @user.update(user_params)
      render :show
    else
      render_error
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_company, :user_total_calories, :user_points, :user_gender, :user_fitness_level, :photo, :email, :age, :phone_number, :user_passions)
  end

  def render_error
    render json: { errors: @user.errors.full_messages },
      status: :unprocessable_entity
  end
end
