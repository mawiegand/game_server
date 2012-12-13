class Backend::PartnerSitesController < ApplicationController

  layout 'backend'
  
  before_filter :authenticate_backend
  before_filter :deny_api
  
  def index
    @title = "Partner Sites"
    @backend_user = current_backend_user
    @backend_partner_sites = !@backend_user.admin? && !@backend_user.staff? && @backend_user.partner? ? @backend_user.partner_sites : Backend::PartnerSite.all
    
    @user_groups = []
    
    @backend_partner_sites.each do |site|
      signins_all =      site.characters.non_npc.count
      gross_all =        site.characters.non_npc.sum(:gross),   
      avg_gross_all =    site.characters.non_npc.sum(:gross) / signins_all,   
      avg_playtime_all = site.characters.non_npc.sum(:playtime) / 60 / signins_all
        
      user_group = {}
      user_group[:header] = "#{site.description} (" + (site.referer.empty? ? "" : "referer: #{site.referer}") + (site.r.empty? ? "" : " r=#{site.r}") + ")" 
      user_group[:sign_up_stats] = {
        signins_last_day:         site.characters.non_npc.where(['last_login_at > ?', Time.now - 1.days]).count,
        signins_last_week:        site.characters.non_npc.where(['last_login_at > ?', Time.now - 1.weeks]).count,   
        signins_last_month:       site.characters.non_npc.where(['last_login_at > ?', Time.now - 1.month]).count,   
        signins_all:              signins_all,   
        gross_all:                site.characters.non_npc.sum(:gross),   
        avg_gross_all:            signins_all == 0 ? 0.0 : avg_gross_all.round(2),   
        avg_playtime_all:         signins_all == 0 ? 0 : avg_playtime_all.round,
      }
      user_group[:sign_ups] = site.characters.non_npc.where('fundamental_characters.created_at IS NOT NULL').order('fundamental_characters.created_at DESC').limit(2)
      
      @user_groups << user_group
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

    @backend_partner_site.referer.strip!
    @backend_partner_site.r.strip! 

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

    @backend_partner_site.referer.strip!
    @backend_partner_site.r.strip! 

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
