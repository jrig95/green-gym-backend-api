class Api::V1::RewardsController < Api::V1::BaseController
  # acts_as_token_authentication_handler_for User #, except: [ :index, :show ]
  before_action :set_reward, only: [ :show, :update, :destroy]

  def index
    @rewards = policy_scope(Reward)
    @rewards = @rewards.reverse
  end

  def show
  end

  def update
    if @reward.update(reward_params)
      render :show
    else
      render_error
    end
  end

  def create
    @reward = Reward.new(reward_params)
    
    authorize @reward
    # @reward.programs << Program.where(id: @reward.program_id)
    if @reward.save!
      render :show, status: :created
    else
      puts "Didn't save"
      render_error
    end
  end

  # Below create method can create a stand alone reward
  # def create
  #   @reward = Reward.new(reward_params)
  #   authorize @reward
  #   byebug
  #   if @reward.save
  #     render :show, status: :created
  #   else
  #     render_error
  #   end
  # end

  def destroy
    @reward.destroy
    head :no_content
  end

  private

  def set_reward
    @reward = Reward.find(params[:id])
    authorize @reward
  end

  def reward_params
    params.require(:reward).permit(:reward_name, :reward_points, :program_id, :visible, :photo)
  end

  # def set_program
  #   @program = Program.where(id: @reward.program_id)
  # end

  def render_error
    render json: { errors: @reward.errors.full_messages },
    status: :unprocessable_entity
  end
end
