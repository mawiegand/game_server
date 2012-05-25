class Settlement::SlotsController < ApplicationController
  layout 'settlement'

  before_filter :authenticate

  # Returns a list of slots for a settlement
  #
  # GET /settlement/settlement/:settlement_id/slots
  # GET /settlement/settlement/:settlement_id/slots.json
  # GET /settlement/slots
  # GET /settlement/slots.json
  def index
    last_modified = nil
    
    if params.has_key?(:settlement_id)
      @own_settlements = Settlement::Settlement.find(:all, :conditions => {:owner_id => current_character.id});
      @settlement_slots = []
      @own_settlements.each do |settlement|
        settlement.slots.each do |slot|
          @settlement_slots << slot
        end
      end
    else 
      @asked_for_index = true
    end   
    
    render_not_modified_or(last_modified) do
      respond_to do |format|
        format.html do
          if @settlement_slots.nil?
            @settlement_slots = Settlement::Slot.paginate(:page => params[:page], :per_page => 50)    
            @paginate = true   
          end 
        end
        format.json do
          if @asked_for_index 
            raise ForbiddenError.new('Access Forbidden')        
          end  
          
          if params.has_key?(:short)
            render json: @settlement_slots, :only => @@short_fields
          elsif params.has_key?(:aggregate)
            render json: @settlement_slots, :only => @@aggregate_fields          
          else
            render json: @settlement_slots
          end
        end
      end
    end
  end

  # GET /settlement/slots/1
  # GET /settlement/slots/1.json
  def show
    @settlement_slot = Settlement::Slot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json do
        unless @settlement_slot.settlement.owner == current_character
          raise ForbiddenError.new('Access Forbidden')        
        end
        render json: @settlement_slot
      end
    end
  end

  # GET /settlement/slots/new
  # GET /settlement/slots/new.json
  def new
    @settlement_slot = Settlement::Slot.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @settlement_slot }
    end
  end

  # GET /settlement/slots/1/edit
  def edit
    @settlement_slot = Settlement::Slot.find(params[:id])
  end

  # POST /settlement/slots
  # POST /settlement/slots.json
  def create
    @settlement_slot = Settlement::Slot.new(params[:settlement_slot])

    respond_to do |format|
      if @settlement_slot.save
        format.html { redirect_to @settlement_slot, notice: 'Slot was successfully created.' }
        format.json { render json: @settlement_slot, status: :created, location: @settlement_slot }
      else
        format.html { render action: "new" }
        format.json { render json: @settlement_slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /settlement/slots/1
  # PUT /settlement/slots/1.json
  def update
    @settlement_slot = Settlement::Slot.find(params[:id])

    respond_to do |format|
      if @settlement_slot.update_attributes(params[:settlement_slot])
        format.html { redirect_to @settlement_slot, notice: 'Slot was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @settlement_slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settlement/slots/1
  # DELETE /settlement/slots/1.json
  def destroy
    @settlement_slot = Settlement::Slot.find(params[:id])
    @settlement_slot.destroy

    respond_to do |format|
      format.html { redirect_to settlement_slots_url }
      format.json { head :ok }
    end
  end
end
