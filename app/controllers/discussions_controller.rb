class DiscussionsController < ApplicationController
  before_action :set_discussion, only: %i[show edit update destroy]
  before_action :set_user
  before_action :user_owns_discussion, only: %i[edit update destroy]

  # GET /discussions or /discussions.json
  def index
    @page_title = 'Discussions'
    @discussions = Discussion.all
  end

  # GET /discussions/1 or /discussions/1.json
  def show
    @page_title = @discussion.title
  end

  # GET /discussions/new
  def new
    @page_title = 'New Discussion'
    @discussion = Discussion.new
    @discussion.user = @user
  end

  # GET /discussions/1/edit
  def edit
    @page_title = "Edit | #{@discussion.title}"
  end

  # POST /discussions or /discussions.json
  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.user = @user

    respond_to do |format|
      if @discussion.save
        format.html { redirect_to discussion_url(@discussion), notice: 'Discussion was successfully created.' }
        format.json { render :show, status: :created, location: @discussion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /discussions/1 or /discussions/1.json
  def update
    respond_to do |format|
      if @discussion.update(discussion_params)
        format.html { redirect_to discussion_url(@discussion), notice: 'Discussion was successfully updated.' }
        format.json { render :show, status: :ok, location: @discussion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discussions/1 or /discussions/1.json
  def destroy
    @discussion.destroy!

    respond_to do |format|
      format.html { redirect_to discussions_url, notice: 'Discussion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def discussion_params
    params.require(:discussion).permit(:title, :description)
  end

  def set_user
    @user = current_user
  end

  def user_owns_discussion
    return if current_user == @discussion.user

    flash[:notice] = 'You are not authorized to do that.'
    redirect_to @discussion

  end
end
