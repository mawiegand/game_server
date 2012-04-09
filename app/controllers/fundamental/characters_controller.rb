class Fundamental::CharactersController < ApplicationController
  layout 'fundamental'
  
  # GET /fundamental/characters
  # GET /fundamental/characters.json
  def index
    @fundamental_characters = Fundamental::Character.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fundamental_characters }
    end
  end

  def self
    # this is to handle a bug in Safari (and other browsers), that lose a custom Authorization header when following a redirect
    #if !params[:access_token].blank? && request_authorization && request_authorization[:method] != :header  # if a_t was in body (POST) or query (GET), append it as argument 
    #  redirect_to polymorphic_path(current_identity, :access_token => params[:access_token])
    #else
      redirect_to fundamental_character_path(current_character_id)
    #end
  end

  # GET /fundamental/characters/1
  # GET /fundamental/characters/1.json
  def show
    @fundamental_character = Fundamental::Character.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_character }
    end
  end

  # GET /fundamental/characters/new
  # GET /fundamental/characters/new.json
  def new
    @fundamental_character = Fundamental::Character.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_character }
    end
  end

  # GET /fundamental/characters/1/edit
  def edit
    @fundamental_character = Fundamental::Character.find(params[:id])
  end

  # POST /fundamental/characters
  # POST /fundamental/characters.json
  def create
    @fundamental_character = Fundamental::Character.new(params[:fundamental_character])

    respond_to do |format|
      if @fundamental_character.save
        format.html { redirect_to @fundamental_character, notice: 'Character was successfully created.' }
        format.json { render json: @fundamental_character, status: :created, location: @fundamental_character }
      else
        format.html { render action: "new" }
        format.json { render json: @fundamental_character.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/characters/1
  # PUT /fundamental/characters/1.json
  def update
    @fundamental_character = Fundamental::Character.find(params[:id])

    respond_to do |format|
      if @fundamental_character.update_attributes(params[:fundamental_character])
        format.html { redirect_to @fundamental_character, notice: 'Character was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_character.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/characters/1
  # DELETE /fundamental/characters/1.json
  def destroy
    @fundamental_character = Fundamental::Character.find(params[:id])
    @fundamental_character.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_characters_url }
      format.json { head :ok }
    end
  end
end
