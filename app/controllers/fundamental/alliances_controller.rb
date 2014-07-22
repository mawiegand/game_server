class Fundamental::AlliancesController < ApplicationController
  layout 'fundamental'
  
  #before_filter :authenticate
  #before_filter :deny_api, :except => [:show, :update]

  
  # GET /fundamental/alliances
  # GET /fundamental/alliances.json
  def index
    raise ForbiddenError.new('Acess denied.') unless staff?
    @fundamental_alliances = Fundamental::Alliance.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /fundamental/alliances/1
  # GET /fundamental/alliances/1.json
  def show
    @fundamental_alliance = Fundamental::Alliance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json do
        role = determine_access_role(@fundamental_alliance.leader_id, @fundamental_alliance.id)
        alliance_hash = @fundamental_alliance.sanitized_hash(role)
        
        if !current_character.nil? && !@fundamental_alliance.nil? && !alliance_hash.nil? && current_character.alliance == @fundamental_alliance
          alliance_hash[:vote_candidate_id] = current_character.voted_for_candidate_id
        end
        
        render json: include_root(alliance_hash, :alliance)
      end
    end
  end

  # GET /fundamental/alliances/new
  # GET /fundamental/alliances/new.json
  def new
    raise ForbiddenError.new('Acess denied.') unless staff?
    @fundamental_alliance = Fundamental::Alliance.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /fundamental/alliances/1/edit
  def edit
    raise ForbiddenError.new('Acess denied.') unless staff?
    @fundamental_alliance = Fundamental::Alliance.find(params[:id])
  end

  # POST /fundamental/alliances
  # POST /fundamental/alliances.json
  def create
    raise ForbiddenError.new('Non-staff tried to create an alliance') unless staff?
    @fundamental_alliance = Fundamental::Alliance.new(params[:fundamental_alliance], :as => :creator)
    
    respond_to do |format|
      if @fundamental_alliance.save
        format.html { redirect_to @fundamental_alliance, notice: 'Alliance was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /fundamental/alliances/1
  # PUT /fundamental/alliances/1.json
  def update
    @fundamental_alliance = Fundamental::Alliance.find(params[:id])
    role = determine_access_role(@fundamental_alliance.leader_id, @fundamental_alliance.id)   
    logger.debug "ROLE: " + role.to_s

    if staff? && !params[:fundamental_alliance][:color_nil].nil?
      @fundamental_alliance.set_color(params[:fundamental_alliance])
    end

    raise ForbiddenError.new 'tried to update an alliance without permission.' unless staff? || role == :owner

    respond_to do |format|
      if @fundamental_alliance.update_attributes(params[:fundamental_alliance], :as => role)
        format.html { redirect_to @fundamental_alliance, notice: 'Alliance was successfully updated.' }
        format.json { render json: {}, status: :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_alliance.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # DELETE /fundamental/alliances/1
  # DELETE /fundamental/alliances/1.json
  def destroy
    raise ForbiddenError.new('Non-staff tried to destroy an alliance') unless staff?
    @fundamental_alliance = Fundamental::Alliance.find(params[:id])
    @fundamental_alliance.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_alliances_url }
    end
  end
end
