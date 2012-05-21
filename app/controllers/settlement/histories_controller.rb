class Settlement::HistoriesController < ApplicationController
  layout 'settlement'

  # GET /settlement/histories
  # GET /settlement/histories.json
  def index
    @settlement_histories = Settlement::History.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @settlement_histories }
    end
  end

  # GET /settlement/histories/1
  # GET /settlement/histories/1.json
  def show
    @settlement_history = Settlement::History.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @settlement_history }
    end
  end

  # GET /settlement/histories/new
  # GET /settlement/histories/new.json
  def new
    @settlement_history = Settlement::History.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @settlement_history }
    end
  end

  # GET /settlement/histories/1/edit
  def edit
    @settlement_history = Settlement::History.find(params[:id])
  end

  # POST /settlement/histories
  # POST /settlement/histories.json
  def create
    @settlement_history = Settlement::History.new(params[:settlement_history])

    respond_to do |format|
      if @settlement_history.save
        format.html { redirect_to @settlement_history, notice: 'History was successfully created.' }
        format.json { render json: @settlement_history, status: :created, location: @settlement_history }
      else
        format.html { render action: "new" }
        format.json { render json: @settlement_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /settlement/histories/1
  # PUT /settlement/histories/1.json
  def update
    @settlement_history = Settlement::History.find(params[:id])

    respond_to do |format|
      if @settlement_history.update_attributes(params[:settlement_history])
        format.html { redirect_to @settlement_history, notice: 'History was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @settlement_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settlement/histories/1
  # DELETE /settlement/histories/1.json
  def destroy
    @settlement_history = Settlement::History.find(params[:id])
    @settlement_history.destroy

    respond_to do |format|
      format.html { redirect_to settlement_histories_url }
      format.json { head :ok }
    end
  end
end
