class Api::V1::ProgramRewardsController < Api::V1::BaseController

  acts_as_token_authentication_handler_for User, except: [:index, :show]
  before_action :set_program_reward, only: [ :show, :update, :destroy ]

  def index
    @program_rewards = policy_scope(ProgramReward)
  end

  def show
  end

  def update
    if @program_reward.update(program_reward_params)
      render :show
    else
      render_error
    end
  end

  def create
  #  Step 1
  # Create @program_reward
    @program_reward = ProgramReward.new(program_reward_params)
    reward_id = params[:reward_id].to_i
    # Step 2
    # Find the current Reward
    # reward = @program_reward.reward
    reward = Reward.where(id: reward_id)
    byebug
    # reward.save
    # Step 3
    # Find the program the admin wants to assign to the reward
    program = Program.where(id: @program_reward.program_id) #--> this gets you the program
    # program.save
    # Step 4
    # push the program to the reward's programs array
    reward.programs >> program
    if @program_reward.save
      render :show, status: :create
    else
      render_error
    end
  end

  def destroy
    @program_reward.destroy
    head :no_content
  end

  private

  def set_program_reward
    @program_reward = ProgramReward.find(params[:id])
    # @reward = @program_reward.reward
    authorize @program_reward
  end

  def program_reward_params
    params.require(:program_reward).permit(:reward_id, :program_id, :programs)
  end

  # def set_program
  #   @program = Program.where(id: @program_reward.program_id)
  # end

  def render_error
    render json: { errors: @program_reward.errors.full_messages},
      status: :unprocessable_entity
  end

end
