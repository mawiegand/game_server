class LikeSystem::LikesController < ApplicationController
  layout 'like_system'

  before_filter :authenticate
  
  # GET /like_system/likes
  # GET /like_system/likes.json
  def index
    @like_system_likes = LikeSystem::Like.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @like_system_likes }
    end
  end

  # GET /like_system/likes/1
  # GET /like_system/likes/1.json
  def show
    @like_system_like = LikeSystem::Like.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @like_system_like }
    end
  end

  # GET /like_system/likes/new
  # GET /like_system/likes/new.json
  def new
    @like_system_like = LikeSystem::Like.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @like_system_like }
    end
  end

  # GET /like_system/likes/1/edit
  def edit
    @like_system_like = LikeSystem::Like.find(params[:id])
  end

  # POST /like_system/likes
  # POST /like_system/likes.json
  def create
    @like_system_like = LikeSystem::Like.new(params[:like_system_like])

    respond_to do |format|
      if @like_system_like.save
        format.html { redirect_to @like_system_like, notice: 'Like was successfully created.' }
        format.json { render json: @like_system_like, status: :created, location: @like_system_like }
      else
        format.html { render action: "new" }
        format.json { render json: @like_system_like.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /like_system/likes/1
  # PUT /like_system/likes/1.json
  def update
    @like_system_like = LikeSystem::Like.find(params[:id])

    respond_to do |format|
      if @like_system_like.update_attributes(params[:like_system_like])
        format.html { redirect_to @like_system_like, notice: 'Like was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @like_system_like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /like_system/likes/1
  # DELETE /like_system/likes/1.json
  def destroy
    @like_system_like = LikeSystem::Like.find(params[:id])
    @like_system_like.destroy

    respond_to do |format|
      format.html { redirect_to like_system_likes_url }
      format.json { head :ok }
    end
  end
end
