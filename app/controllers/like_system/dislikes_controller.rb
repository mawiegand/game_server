class LikeSystem::DislikesController < ApplicationController
  before_filter :authenticate
  
  # GET /like_system/dislikes
  # GET /like_system/dislikes.json
  def index
    @like_system_dislikes = LikeSystem::Dislike.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @like_system_dislikes }
    end
  end

  # GET /like_system/dislikes/1
  # GET /like_system/dislikes/1.json
  def show
    @like_system_dislike = LikeSystem::Dislike.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @like_system_dislike }
    end
  end

  # GET /like_system/dislikes/new
  # GET /like_system/dislikes/new.json
  def new
    @like_system_dislike = LikeSystem::Dislike.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @like_system_dislike }
    end
  end

  # GET /like_system/dislikes/1/edit
  def edit
    @like_system_dislike = LikeSystem::Dislike.find(params[:id])
  end

  # POST /like_system/dislikes
  # POST /like_system/dislikes.json
  def create
    @like_system_dislike = LikeSystem::Dislike.new(params[:like_system_dislike])

    respond_to do |format|
      if @like_system_dislike.save
        format.html { redirect_to @like_system_dislike, notice: 'Dislike was successfully created.' }
        format.json { render json: @like_system_dislike, status: :created, location: @like_system_dislike }
      else
        format.html { render action: "new" }
        format.json { render json: @like_system_dislike.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /like_system/dislikes/1
  # PUT /like_system/dislikes/1.json
  def update
    @like_system_dislike = LikeSystem::Dislike.find(params[:id])

    respond_to do |format|
      if @like_system_dislike.update_attributes(params[:like_system_dislike])
        format.html { redirect_to @like_system_dislike, notice: 'Dislike was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @like_system_dislike.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /like_system/dislikes/1
  # DELETE /like_system/dislikes/1.json
  def destroy
    @like_system_dislike = LikeSystem::Dislike.find(params[:id])
    @like_system_dislike.destroy

    respond_to do |format|
      format.html { redirect_to like_system_dislikes_url }
      format.json { head :ok }
    end
  end
end
