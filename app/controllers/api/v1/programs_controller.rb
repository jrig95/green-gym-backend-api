class Api::V1::ProgramsController < Api::V1::BaseController
  # acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :authenticate_user!, except: [:index, :show, :last_program]
  before_action :set_program, only: [ :show,:update, :destroy, :current_program_impact ]

  def index
    @programs = policy_scope(Program)
    # @programs = @programs.reverse
    @programs = Program.order(created_at: :desc)
  end

  def show
    @daily_workouts = @program.daily_workouts.sort { |a, b| a.id <=> b.id }
  end

  def update
    if @program.update(program_params)
      # render :show
    else
      render_error
    end
  end

  def create
    @program = Program.new(program_params)
    authorize @program
    if @program.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @program.destroy
    head :no_content
  end

  def last_program
    @program = Program.last
    authorize @program
  end

  def current_program_impact
    @users = @program.users
    @users = (@users.order(user_total_calories: :desc))
    program_total_calories = 0
    @users.each do |user|
      program_total_calories += user.user_total_calories
    end
      @program_total_calories = program_total_calories
      # authorize @user
  end

  private

  def set_program
    @program = Program.find(params[:id])
    authorize @program
  end

  def program_params
    params.require(:program).permit(:program_title, :program_description, :number_of_days, :price, :calories_burned, :trees_planted, :calorie_credits, :photo, :program_library_item_id)
  end

  def render_error
    render json: { errors: @program.errors.full_messages },
      status: :unprocessable_entity
  end

end
