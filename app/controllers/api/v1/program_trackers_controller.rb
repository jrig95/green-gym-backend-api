class Api::V1::ProgramTrackersController < Api::V1::BaseController
  # acts_as_token_authentication_handler_for User #, except: [ :index, :show ]
  before_action :set_program_tracker, only: [ :show, :update, :destroy ]

  def index
    @program_trackers = policy_scope(ProgramTracker)
  end

  def show
  end

  def update
    if @program_tracker.update(program_tracker_params)
      render :show
    else
      render_error
    end
  end

  def create
    @program_tracker = ProgramTracker.new(program_tracker_params)
    authorize @program_tracker
    if @program_tracker.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @program_tracker.destroy
    head :no_content
  end

  private

  def set_program_tracker
    @program_tracker = ProgramTracker.find(params[:id])
    authorize @program_tracker
  end

  def program_tracker_params
    params.require(:program_tracker).permit(:program_id, :user_id)
  end

  def render_error
    render json: { errors: @program_tracker.errors.full_messages },
      status: :unprocessable_entity
  end


end
