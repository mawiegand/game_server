class Fundamental::AllianceShoutsController < ApplicationController
  layout 'fundamental'


  def index

    last_modified = nil 

    if params.has_key?(:alliance_id)  
      @alliance = Fundamental::Alliance.find(params[:alliance_id])
      raise NotFoundError.new('Page Not Found') if @alliance.nil?
      @fundamental_alliance_shouts = @alliance.shouts
      # todo -> determine last_modified
    elsif params.has_key?(:character_id)  
      @character = Fundamental::Character.find(params[:character_id])
      raise NotFoundError.new('Page Not Found') if @character.nil?
      @fundamental_alliance_shouts = @character.alliance_shouts
      # todo -> determine last_modified
    else
      @asked_for_index = true
    end   

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          if @fundamental_alliance_shouts.nil?
            @fundamental_alliance_shouts =  Fundamental::AllianceShout.paginate(:page => params[:page], :per_page => 50)    
            @paginate = true   
          end 
        end
        format.json do
          if @asked_for_index 
            raise ForbiddenError.new('Access Forbidden')        
          end  
          @fundamental_alliance_shouts = [] if @fundamental_alliance_shouts.nil?  # necessary? or ok to send 'null' ?
          if params.has_key?(:short)
            render json: @fundamental_alliance_shouts, :only => @@short_fields
          elsif params.has_key?(:aggregate)
            render json: @fundamental_alliance_shouts, :only => @@aggregate_fields          
          else
            render json: @fundamental_alliance_shouts
          end
        end
      end
    end
  end

  # GET /fundamental/alliance_shouts/1
  # GET /fundamental/alliance_shouts/1.json
  def show
    @fundamental_alliance_shout = Fundamental::AllianceShout.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_alliance_shout }
    end
  end

  # GET /fundamental/alliance_shouts/new
  # GET /fundamental/alliance_shouts/new.json
  def new
    @fundamental_alliance_shout = Fundamental::AllianceShout.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_alliance_shout }
    end
  end

  # GET /fundamental/alliance_shouts/1/edit
  def edit
    @fundamental_alliance_shout = Fundamental::AllianceShout.find(params[:id])
  end

  # POST /fundamental/alliance_shouts
  # POST /fundamental/alliance_shouts.json
  def create

    respond_to do |format|
      format.html do 
        @fundamental_alliance_shout = Fundamental::AllianceShout.new(params[:fundamental_alliance_shout])
        if @fundamental_alliance_shout.save
          redirect_to @fundamental_alliance_shout, notice: 'Alliance shout was successfully created.' 
        else 
          render action: "new"
        end
      end
      format.json do
        raise ForbiddenError.new('No current character.') if current_character.nil?
        raise ForbiddenError.new('Current character is in no alliance.') if current_character.alliance.nil?
        raise BadRequestError.new('No message sent.') if params[:fundamental_alliance_shout][:message].blank?
        
        new_message = { :message => params[:fundamental_alliance_shout][:message],
                        :character_id => current_character.id,
                        :alliance_id => current_character.alliance_id }
        
        @fundamental_alliance_shout = Fundamental::AllianceShout.new(new_message)        
        if @fundamental_alliance_shout.save
          render json: @fundamental_alliance_shout, status: :created, location: @fundamental_alliance_shout 
        else 
          format.json { render json: @fundamental_alliance_shout.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /fundamental/alliance_shouts/1
  # PUT /fundamental/alliance_shouts/1.json
  def update
    @fundamental_alliance_shout = Fundamental::AllianceShout.find(params[:id])

    respond_to do |format|
      if @fundamental_alliance_shout.update_attributes(params[:fundamental_alliance_shout])
        format.html { redirect_to @fundamental_alliance_shout, notice: 'Alliance shout was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_alliance_shout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/alliance_shouts/1
  # DELETE /fundamental/alliance_shouts/1.json
  def destroy
    @fundamental_alliance_shout = Fundamental::AllianceShout.find(params[:id])
    @fundamental_alliance_shout.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_alliance_shouts_url }
      format.json { head :ok }
    end
  end
end
