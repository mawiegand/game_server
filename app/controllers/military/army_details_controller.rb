class Military::ArmyDetailsController < ApplicationController
  layout 'military'

  before_filter :authenticate
  before_filter :deny_api,        :except => [:show, :index]
  before_filter :authorize_staff, :except => [:show, :index]


  # GET /military/army_details
  # GET /military/army_details.json
  def index

    last_modified = nil 

    if params.has_key?(:army_id)  
      @army = Military::Army.find(params[:army_id])
      raise NotFoundError.new('Page Not Found') if @army.nil?
      @military_army_details = @army.details 
      raise NotFoundError.new('Page Not Found') if @military_army_details.nil?
      last_modified =  @military_army_details.updated_at
    else
      @asked_for_index = true
    end   

    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          if @military_army_details.nil?
            @military_army_details =  Military::ArmyDetail.paginate(:page => params[:page], :per_page => 50)    
            @paginate = true   
          end 
        end
        format.json do
          if @asked_for_index 
            raise ForbiddenError.new('Access Forbidden')        
          end  
          @military_army_details = [] if @military_army_details.nil?  # necessary? or ok to send 'null' ?
          render json: @military_army_details
        end
      end
    end
  end

  # GET /military/army_details/1
  # GET /military/army_details/1.json
  def show
    @military_army_detail = Military::ArmyDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @military_army_detail }
    end
  end

  # GET /military/army_details/new
  # GET /military/army_details/new.json
  def new
    @military_army_detail = Military::ArmyDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @military_army_detail }
    end
  end

  # GET /military/army_details/1/edit
  def edit
    @military_army_detail = Military::ArmyDetail.find(params[:id])
  end

  # POST /military/army_details
  # POST /military/army_details.json
  def create
    @military_army_detail = Military::ArmyDetail.new(params[:military_army_detail])

    respond_to do |format|
      if @military_army_detail.save
        format.html { redirect_to @military_army_detail, notice: 'Army detail was successfully created.' }
        format.json { render json: @military_army_detail, status: :created, location: @military_army_detail }
      else
        format.html { render action: "new" }
        format.json { render json: @military_army_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /military/army_details/1
  # PUT /military/army_details/1.json
  def update
    @military_army_detail = Military::ArmyDetail.find(params[:id])

    respond_to do |format|
      if @military_army_detail.update_attributes(params[:military_army_detail])
        format.html { redirect_to @military_army_detail, notice: 'Army detail was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @military_army_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /military/army_details/1
  # DELETE /military/army_details/1.json
  def destroy
    @military_army_detail = Military::ArmyDetail.find(params[:id])
    @military_army_detail.destroy

    respond_to do |format|
      format.html { redirect_to military_army_details_url }
      format.json { head :ok }
    end
  end
end
