# frozen_string_literal: true
class UsersController < ApplicationController
  include Access
  before_action :authenticate_user!
  before_action :user_is_admin
  before_action :set_user, except: %i[index]

  # GET /users or /users.json
  def index
    @page_title = 'Users'
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @page_title = @user.email
  end

  # GET /users/new
  # def new
  #   @page_title = 'New Discussion'
  #   @discussion = Discussion.new
  #   @discussion.user = @user
  # end

  # GET /users/1/edit
  # def edit
  #   @page_title = "Edit | #{@discussion.title}"
  # end

  # POST /users or /users.json
  # def create
  #   @discussion = Discussion.new(discussion_params)
  #   @discussion.user = @user
  #
  #   respond_to do |format|
  #     if @discussion.save
  #       format.html { redirect_to discussion_url(@discussion), notice: 'Discussion was successfully created.' }
  #       format.json { render :show, status: :created, location: @discussion }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @discussion.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # PATCH/PUT /users/1 or /users/1.json
  # def update
  #   respond_to do |format|
  #     if @user.update(user_params)
  #       format.html { redirect_to user_url(@user), notice: 'Discussion was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @user }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  # def user_params
  #   params.require(:user)#.permit(:title, :description)
  # end

  def set_user
    @user = User.find(params[:id])
  end
end
