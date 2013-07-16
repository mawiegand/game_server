class Backend::UserContentReportsController < ApplicationController
  layout 'backend'  
  
  before_filter :authenticate
  before_filter :deny_api
  before_filter :authorize_staff

  # GET /backend/user_content_reports
  # GET /backend/user_content_reports.json
  def index
    @backend_user_content_reports = Backend::UserContentReport.paginate(:order => 'created_at DESC', :page => params[:page], :per_page => 50)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @backend_user_content_reports }
    end
  end

  # GET /backend/user_content_reports/1
  # GET /backend/user_content_reports/1.json
  def show
    @backend_user_content_report = Backend::UserContentReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @backend_user_content_report }
    end
  end

  # GET /backend/user_content_reports/new
  # GET /backend/user_content_reports/new.json
  def new
    @backend_user_content_report = Backend::UserContentReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @backend_user_content_report }
    end
  end

  # GET /backend/user_content_reports/1/edit
  def edit
    @backend_user_content_report = Backend::UserContentReport.find(params[:id])
  end

  # POST /backend/user_content_reports
  # POST /backend/user_content_reports.json
  def create
    @backend_user_content_report = Backend::UserContentReport.new(params[:backend_user_content_report])

    respond_to do |format|
      if @backend_user_content_report.save
        format.html { redirect_to @backend_user_content_report, notice: 'User content report was successfully created.' }
        format.json { render json: @backend_user_content_report, status: :created, location: @backend_user_content_report }
      else
        format.html { render action: "new" }
        format.json { render json: @backend_user_content_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /backend/user_content_reports/1
  # PUT /backend/user_content_reports/1.json
  def update
    @backend_user_content_report = Backend::UserContentReport.find(params[:id])

    respond_to do |format|
      if @backend_user_content_report.update_attributes(params[:backend_user_content_report])
        format.html { redirect_to @backend_user_content_report, notice: 'User content report was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @backend_user_content_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /backend/user_content_reports/1
  # DELETE /backend/user_content_reports/1.json
  def destroy
    @backend_user_content_report = Backend::UserContentReport.find(params[:id])
    @backend_user_content_report.destroy

    respond_to do |format|
      format.html { redirect_to backend_user_content_reports_url }
      format.json { head :ok }
    end
  end
end
