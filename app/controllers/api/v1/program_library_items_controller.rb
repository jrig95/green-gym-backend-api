class Api::V1::ProgramLibraryItemsController < Api::V1::BaseController
  # acts_as_token_authentication_handler_for User
  before_action :authenticate_user!
  before_action :set_program_library_item, only: [ :show,:update, :destroy ]

  def index
    if params[:query].present?
      sql_query = " \
        title ILIKE :query \
      "
      @program_library_items = policy_scope(ProgramLibraryItem.where(sql_query, query: "%#{params[:query]}%"))
    else
      @program_library_items = policy_scope(ProgramLibraryItem)
      @program_library_items = @program_library_items.reverse
    end
  end

  def show
  end

  def update
    if @program_library_item.update(program_library_item_params)
      render :show
    else
      render_error
    end
  end

  def create
    @program_library_item = ProgramProgramLibraryItem.new(program_library_item_params)
    authorize @program_library_item
    if @program_library_item.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @program_library_item.destroy
    head :no_content
  end

  private

  def set_library_item
    @program_library_item = ProgramProgramLibraryItem.find(params[:id])
    authorize @program_library_item
  end

  def program_library_item_params
    params.require(:program_library_item).permit(:title, :video, :photo, tag_list: [])
  end

  def render_error
    render json: { errors: @program_library_item.errors.full_messages },
    status: :unprocessable_entity
  end
end
