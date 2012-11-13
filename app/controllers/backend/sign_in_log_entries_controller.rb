class Backend::SignInLogEntriesController < ApplicationController
  layout 'backend'
  
  before_filter :deny_api
  before_filter :authenticate_backend  
  before_filter :authorize_staff

  # GET /backend/sign_in_log_entries
  # GET /backend/sign_in_log_entries.json
  def index
    @backend_sign_in_log_entries = Backend::SignInLogEntry.paginate(:order => 'created_at DESC', :page => params[:page], :per_page => 50) 

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @backend_sign_in_log_entries }
    end
  end

  # GET /backend/sign_in_log_entries/1
  # GET /backend/sign_in_log_entries/1.json
  def show
    @backend_sign_in_log_entry = Backend::SignInLogEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @backend_sign_in_log_entry }
    end
  end

  # GET /backend/sign_in_log_entries/new
  # GET /backend/sign_in_log_entries/new.json
  def new
    @backend_sign_in_log_entry = Backend::SignInLogEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @backend_sign_in_log_entry }
    end
  end

  # GET /backend/sign_in_log_entries/1/edit
  def edit
    @backend_sign_in_log_entry = Backend::SignInLogEntry.find(params[:id])
  end

  # POST /backend/sign_in_log_entries
  # POST /backend/sign_in_log_entries.json
  def create
    @backend_sign_in_log_entry = Backend::SignInLogEntry.new(params[:backend_sign_in_log_entry])

    respond_to do |format|
      if @backend_sign_in_log_entry.save
        format.html { redirect_to @backend_sign_in_log_entry, notice: 'Sign in log entry was successfully created.' }
        format.json { render json: @backend_sign_in_log_entry, status: :created, location: @backend_sign_in_log_entry }
      else
        format.html { render action: "new" }
        format.json { render json: @backend_sign_in_log_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /backend/sign_in_log_entries/1
  # PUT /backend/sign_in_log_entries/1.json
  def update
    @backend_sign_in_log_entry = Backend::SignInLogEntry.find(params[:id])

    respond_to do |format|
      if @backend_sign_in_log_entry.update_attributes(params[:backend_sign_in_log_entry])
        format.html { redirect_to @backend_sign_in_log_entry, notice: 'Sign in log entry was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @backend_sign_in_log_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /backend/sign_in_log_entries/1
  # DELETE /backend/sign_in_log_entries/1.json
  def destroy
    @backend_sign_in_log_entry = Backend::SignInLogEntry.find(params[:id])
    @backend_sign_in_log_entry.destroy

    respond_to do |format|
      format.html { redirect_to backend_sign_in_log_entries_url }
      format.json { head :ok }
    end
  end
end
