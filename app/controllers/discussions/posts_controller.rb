class Discussions::PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_discussion
  before_action :set_user
  before_action :user_owns_post, only: %i[edit update destroy]

  # GET /posts or /posts.json
  def index
    @page_title = 'Posts'
    @posts = Post.all.order(created_at: :desc)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @page_title = @post.discussion.title
  end

  # GET /posts/new
  def new
    @page_title = 'New Post'
    @post = Post.new
    @post.discussion = @discussion
    @post.user = @user
  end

  # GET /posts/1/edit
  def edit
    @page_title = 'Edit | ' + @post.discussion.title
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.discussion = @discussion
    @post.user = @user

    respond_to do |format|
      if @post.save
        format.html { redirect_to discussion_path(@post.discussion), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to discussion_url(@post.discussion), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    discussion = @post.discussion
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to discussion_url(discussion), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def set_discussion
    @discussion = Discussion.find(params[:discussion_id])
  end

  def set_user
    @user = current_user
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:text, :discussion_id)
  end

  def user_owns_post
    return if current_user == @post.user

    flash[:notice] = 'You are not authorized to do that.'
    redirect_to @post.discussion

  end
end
