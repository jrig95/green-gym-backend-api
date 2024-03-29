# class Api::V1::UsersController < ApplicationController
class Api::V1::UsersController < Api::V1::BaseController
  # should use the authenticate_user! for JWT
  before_action :authenticate_user!, except: [:forgot_password, :reset_password, :verify_code]
  # acts_as_token_authentication_handler_for User
  before_action :set_user, only: [ :show, :update, :update_password, :destroy, :overall_impact, :add_active_time ]

  def index
    if params[:query].present?
      sql_query = " \
        email ILIKE :query \
        OR first_name ILIKE :query \
        OR last_name ILIKE :query \
        OR user_company ILIKE :query \
        OR user_fitness_level ILIKE :query \
      "
      @users = policy_scope(User.where(sql_query, query: "%#{params[:query]}%").order(created_at: :desc))
    else
      @users = policy_scope(User.order(created_at: :desc))
    end
  end

  def sort_by_first_name
    @users = (User.order(first_name: :asc))
    authorize @users
  end

  def sort_by_last_name
    @users = (User.order(last_name: :asc))
    authorize @users
  end

  def sort_by_user_company
    @users = (User.order(user_company: :asc))
    authorize @users
  end

  def sort_by_last_sign_in_at
    @users = (User.order(last_sign_in_at: :desc))
    authorize @users
  end

  def show
    # if @user.last_sign_in_at.present?
    #   @user.last_sign_in_at = @user.last_sign_in_at.strftime("%-d %B %Y, %-k:%Ma.m.")
    #   @user.current_sign_in_at = @user.current_sign_in_at.strftime("%-d %B %Y, %-k:%Ma.m.")
    # end
  end

  def update_password
    if @user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      render :show
    else
      render "edit"
    end
  end

  def update
    if @user.update(user_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  def forgot_password
    email = params[:user][:email]
    @user = User.find_by(email: email)
    @user.send_reset_password_instructions
    if @user.reset_password_token.present?
      reset_password_token = @user.reset_password_token
      @user.reset_password_token = reset_password_token[0, 6]
      @user.save!
      authorize @user
    else
      render_error
    end
  end

  def reset_password
    token = params[:user][:reset_password_token]
    @user = User.find_by(reset_password_token: token)
    new_password = params[:user][:new_password]
    new_password_confirmation = params[:user][:new_password_confirmation]
    @user.reset_password(new_password, new_password_confirmation)
    authorize @user
  end

  def overall_impact
    @users = (User.order(user_total_calories: :desc))
    authorize @user
  end

  def add_active_time
    active_time = @user.active_time + params[:user][:active_time]
    @user.update(active_time: active_time)
    authorize @user
  end

  private

  def set_user
    @user = User.find(params[:id])
    # @user = current_user
    authorize @user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_company, :user_total_calories, :user_points, :user_gender, :user_fitness_level, :photo, :email, :age, :phone_number, :user_passions, :password, :password_confirmation, :reset_password_token, :new_password, :new_password_confirmation, :active_time)
  end

  def render_error
    render json: { errors: @user.errors.full_messages },
      status: :unprocessable_entity
  end

  # def order_users(field_name)
  #   @users = User.order(field_name: :asc)
  # end
end
