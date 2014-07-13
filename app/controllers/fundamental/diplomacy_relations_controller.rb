class Fundamental::DiplomacyRelationsController < ApplicationController
  layout 'fundamental'
  
  before_filter :authenticate
  before_filter :deny_api, :except => [:show, :index, :edit]
  
  # GET /fundamental/diplomacy_relations
  # GET /fundamental/diplomacy_relations.json
  def index

    last_modified = nil 

    if params.has_key?(:alliance_id)  
      @alliance = Fundamental::Alliance.find(params[:alliance_id])
      raise NotFoundError.new('Page Not Found') if @alliance.nil?
      @fundamental_diplomacy_relations = @alliance.diplomacy_source_relations
      # TODO: Calculate last_modifed
      # last_modified = 
      
      raise ForbiddenError.new "Access Fobidden." unless staff? || admin? || !current_character.nil?
    else
      @fundamental_diplomacy_relations = Fundamental::DiplomacyRelation.all
    end   

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          raise ForbiddenError.new "Access denied. User not authorized."  unless staff? || admin?
          if @fundamental_diplomacy_relations.nil?
            @fundamental_diplomacy_relations =  Fundamental::DiplomacyRelation.paginate(:page => params[:page], :per_page => 50)    
            @paginate = true   
          end 
        end
        format.json do
          if @asked_for_index 
            raise ForbiddenError.new('Access Forbidden')        
          end
          @fundamental_diplomacy_relations = [] if @fundamental_diplomacy_relations.nil?  # necessary? or ok to send 'null' ?
          render json: @fundamental_diplomacy_relations
        end
      end
    end
  end

  # GET /fundamental/diplomacy_relations/1
  # GET /fundamental/diplomacy_relations/1.json
  def show
    @fundamental_diplomacy_relation = Fundamental::DiplomacyRelation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_diplomacy_relation }
    end
  end

  # GET /fundamental/diplomacy_relations/new
  # GET /fundamental/diplomacy_relations/new.json
  def new
    @fundamental_diplomacy_relation = Fundamental::DiplomacyRelation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_diplomacy_relation }
    end
  end

  # GET /fundamental/diplomacy_relations/1/edit
  def edit
    @fundamental_diplomacy_relation = Fundamental::DiplomacyRelation.find(params[:id])
  end

  # POST /fundamental/diplomacy_relations
  # POST /fundamental/diplomacy_relations.json
  def create
    @fundamental_diplomacy_relation = Fundamental::DiplomacyRelation.new(params[:fundamental_diplomacy_relation])
#    fundamental_diplomacy_relation_copy = Fundamental::DiplomacyRelation.new(params[:fundamental_diplomacy_relation])
#    fundamental_diplomacy_relation_copy.source_alliance = @fundamental_diplomacy_relation.target_alliance
#    fundamental_diplomacy_relation_copy.target_alliance = @fundamental_diplomacy_relation.source_alliance
#    fundamental_diplomacy_relation_copy.initiator = !@fundamental_diplomacy_relation.initiator

    respond_to do |format|
      if @fundamental_diplomacy_relation.save #&& fundamental_diplomacy_relation_copy.save
        format.html { redirect_to @fundamental_diplomacy_relation, notice: 'Diplomacy relation was successfully created.' }
        format.json { render json: @fundamental_diplomacy_relation, status: :created, location: @fundamental_diplomacy_relation }
      else
        format.html { render action: "new" }
        format.json { render json: @fundamental_diplomacy_relation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/diplomacy_relations/1
  # PUT /fundamental/diplomacy_relations/1.json
  def update
    @fundamental_diplomacy_relation = Fundamental::DiplomacyRelation.find(params[:id])

    respond_to do |format|
      if @fundamental_diplomacy_relation.update_attributes(params[:fundamental_diplomacy_relation])
        format.html { redirect_to @fundamental_diplomacy_relation, notice: 'Diplomacy relation was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_diplomacy_relation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/diplomacy_relations/1
  # DELETE /fundamental/diplomacy_relations/1.json
  def destroy
    @fundamental_diplomacy_relation = Fundamental::DiplomacyRelation.find(params[:id])
    #Fundamental::DiplomacyRelation.destroy_relations_between(@fundamental_diplomacy_relation.source_alliance, @fundamental_diplomacy_relation.target_alliance)
    @fundamental_diplomacy_relation.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_diplomacy_relations_url }
      format.json { head :ok }
    end
  end
end
