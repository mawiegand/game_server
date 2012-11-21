class Fundamental::RetentionMailsController < ApplicationController
  layout 'fundamental'
  
  before_filter :authenticate
  before_filter :deny_api

  # GET /fundamental/retention_mails
  # GET /fundamental/retention_mails.json
  def index
    @fundamental_retention_mails = Fundamental::RetentionMail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fundamental_retention_mails }
    end
  end

  # GET /fundamental/retention_mails/1
  # GET /fundamental/retention_mails/1.json
  def show
    @fundamental_retention_mail = Fundamental::RetentionMail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_retention_mail }
    end
  end

  # GET /fundamental/retention_mails/new
  # GET /fundamental/retention_mails/new.json
  def new
    @fundamental_retention_mail = Fundamental::RetentionMail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_retention_mail }
    end
  end

  # GET /fundamental/retention_mails/1/edit
  def edit
    @fundamental_retention_mail = Fundamental::RetentionMail.find(params[:id])
  end

  # POST /fundamental/retention_mails
  # POST /fundamental/retention_mails.json
  def create
    @fundamental_retention_mail = Fundamental::RetentionMail.new(params[:fundamental_retention_mail])

    respond_to do |format|
      if @fundamental_retention_mail.save
        format.html { redirect_to @fundamental_retention_mail, notice: 'Retention mail was successfully created.' }
        format.json { render json: @fundamental_retention_mail, status: :created, location: @fundamental_retention_mail }
      else
        format.html { render action: "new" }
        format.json { render json: @fundamental_retention_mail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/retention_mails/1
  # PUT /fundamental/retention_mails/1.json
  def update
    @fundamental_retention_mail = Fundamental::RetentionMail.find(params[:id])

    respond_to do |format|
      if @fundamental_retention_mail.update_attributes(params[:fundamental_retention_mail])
        format.html { redirect_to @fundamental_retention_mail, notice: 'Retention mail was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_retention_mail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/retention_mails/1
  # DELETE /fundamental/retention_mails/1.json
  def destroy
    @fundamental_retention_mail = Fundamental::RetentionMail.find(params[:id])
    @fundamental_retention_mail.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_retention_mails_url }
      format.json { head :ok }
    end
  end
end
