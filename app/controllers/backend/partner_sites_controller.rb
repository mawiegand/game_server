class Backend::PartnerSitesController < ApplicationController

  layout 'backend'
  
  before_filter :authenticate_backend
  before_filter :authorize_staff
  before_filter :deny_api
  
  def index
    @backend_partner_sites = Backend::PartnerSite.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @backend_partner_sites }
    end
  end

  # GET /backend/partner_sites/1
  # GET /backend/partner_sites/1.json
  def show
    @backend_partner_site = Backend::PartnerSite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @backend_partner_site }
    end
  end

  # GET /backend/partner_sites/new
  # GET /backend/partner_sites/new.json
  def new
    @backend_partner_site = Backend::PartnerSite.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @backend_partner_site }
    end
  end

  # GET /backend/partner_sites/1/edit
  def edit
    @backend_partner_site = Backend::PartnerSite.find(params[:id])
  end

  # POST /backend/partner_sites
  # POST /backend/partner_sites.json
  def create
    @backend_partner_site = Backend::PartnerSite.new(params[:backend_partner_site])

    respond_to do |format|
      if @backend_partner_site.save
        format.html { redirect_to @backend_partner_site, notice: 'Partner site was successfully created.' }
        format.json { render json: @backend_partner_site, status: :created, location: @backend_partner_site }
      else
        format.html { render action: "new" }
        format.json { render json: @backend_partner_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /backend/partner_sites/1
  # PUT /backend/partner_sites/1.json
  def update
    @backend_partner_site = Backend::PartnerSite.find(params[:id])

    respond_to do |format|
      if @backend_partner_site.update_attributes(params[:backend_partner_site])
        format.html { redirect_to @backend_partner_site, notice: 'Partner site was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @backend_partner_site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /backend/partner_sites/1
  # DELETE /backend/partner_sites/1.json
  def destroy
    @backend_partner_site = Backend::PartnerSite.find(params[:id])
    @backend_partner_site.destroy

    respond_to do |format|
      format.html { redirect_to backend_partner_sites_url }
      format.json { head :ok }
    end
  end
end
