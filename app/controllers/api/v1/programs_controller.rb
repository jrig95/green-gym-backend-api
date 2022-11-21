class Api::V1::ProgramsController < Api::V1::BaseController
  # acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :authenticate_user!, except: [:index, :show, :last_program]
  before_action :set_program, only: [ :show,:update, :destroy ]

  def index
    @programs = policy_scope(Program)
    @programs = @programs.reverse
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

  private

  def set_program
    @program = Program.find(params[:id])
    authorize @program
  end

  def program_params
    params.require(:program).permit(:program_title, :program_description, :number_of_days, :price, :start_date, :photo)
  end

  def render_error
    render json: { errors: @program.errors.full_messages },
      status: :unprocessable_entity
  end

end
