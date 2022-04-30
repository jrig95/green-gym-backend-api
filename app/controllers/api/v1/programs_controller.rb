class Api::V1::ProgramsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_program, only: [ :show,:update, :destroy ]

  def index
    @programs = policy_scope(Program)
  end

  def show
  end

  def update
    if @program.update(program_params)
      render :show
    else
      render_error
    end
  end

  def create
    @program = Program.new(program_params)
    # Creates a ProgramTracker between the admin and the newly created program
    # @program.users << User.where(admin: true)
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

  private

  def set_program
    @program = Program.find(params[:id])
    authorize @program
  end

  def program_params
    params.require(:program).permit(:program_title, :program_description, :number_of_days, :program_cover_image, :price)
  end

  def render_error
    render json: { errors: @program.errors.full_messages },
      status: :unprocessable_entity
  end

end
