class Api::V1::LibraryItemsController < Api::V1::BaseController
  # acts_as_token_authentication_handler_for User
  before_action :authenticate_user!
  before_action :set_library_item, only: [ :show,:update, :destroy ]

  def index
    if params[:query].present?
      sql_query = " \
        title ILIKE :query \
      "
      @library_items = policy_scope(LibraryItem.where(sql_query, query: "%#{params[:query]}%"))
    else
      @library_items = policy_scope(LibraryItem)
      @library_items = @library_items.order(title: :asc)

    end
  end

  def show
  end

  def update
    if @library_item.update(library_item_params)
      render :show
    else
      render_error
    end
  end

  def create
    @library_item = LibraryItem.new(library_item_params)
    authorize @library_item
    if @library_item.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @library_item.destroy
    head :no_content
  end

  def tagged
    if params[:tag].present?
      @library_items = LibraryItem.tagged_with(params[:tag])
    else
      @library_items = LibraryItem.all
    end
    authorize @library_items
  end

  private

  def set_library_item
    @library_item = LibraryItem.find(params[:id])
    authorize @library_item
  end

  def library_item_params
    params.require(:library_item).permit(:title, :video, :photo, tag_list: [])
  end

  def render_error
    render json: { errors: @library_item.errors.full_messages },
    status: :unprocessable_entity
  end
end
