require 'util'

class Fundamental::AllianceReservationsController < ApplicationController
  layout 'fundamental'

  before_filter :authenticate
  before_filter :deny_api, :except => [:index, :show, :create, :update]

  # GET /fundamental/alliance_reservations
  # GET /fundamental/alliance_reservations.json
  def index
    if params.has_key?(:alliance_id)
      alliance = Fundamental::Alliance.find(params[:alliance_id])
      raise NotFoundError.new('Alliance Not Found')       if alliance.nil?
      raise ForbiddenError.new('Not member of alliance')  unless alliance == current_character.alliance
      raise ForbiddenError.new('Not leader of alliance')  unless alliance.leader == current_character
      @fundamental_alliance_reservations = [alliance.reservation]
    else
      raise ForbiddenError.new('Acess denied.') unless staff?
      @fundamental_alliance_reservations = Fundamental::AllianceReservation.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fundamental_alliance_reservations }
    end
  end

  # GET /fundamental/alliance_reservations/1
  # GET /fundamental/alliance_reservations/1.json
  def show
    if params.has_key?(:alliance_id)
      alliance = Fundamental::Alliance.find(params[:alliance_id])
      raise NotFoundError.new('Alliance Not Found')       if alliance.nil?
      raise ForbiddenError.new('Not member of alliance')  unless alliance == current_character.alliance
      raise ForbiddenError.new('Not leader of alliance')  unless alliance.leader == current_character
      @fundamental_alliance_reservation = alliance.reservation
    else
      raise ForbiddenError.new('Acess denied.') unless staff?
      @fundamental_alliance_reservation = Fundamental::AllianceReservation.find(params[:id])
    end

    if stale?(:last_modified => @fundamental_alliance_reservation.updated_at.utc, :etag => @fundamental_alliance_reservation)
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @fundamental_alliance_reservation }
      end
    end
  end

  # GET /fundamental/alliance_reservations/new
  # GET /fundamental/alliance_reservations/new.json
  def new
    @fundamental_alliance_reservation = Fundamental::AllianceReservation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_alliance_reservation }
    end
  end

  # GET /fundamental/alliance_reservations/1/edit
  def edit
    @fundamental_alliance_reservation = Fundamental::AllianceReservation.find(params[:id])
  end

  # POST /fundamental/alliance_reservations
  # POST /fundamental/alliance_reservations.json
  def create
    if params.has_key?(:alliance_id)
      alliance = Fundamental::Alliance.find(params[:alliance_id])
      raise NotFoundError.new('Alliance Not Found')       if alliance.nil?
      raise ForbiddenError.new('Not member of alliance')  unless alliance == current_character.alliance
      raise ForbiddenError.new('Not leader of alliance')  unless alliance.leader == current_character
      raise BadRequestError.new('Reservation already created') unless alliance.reservation.nil?
      @fundamental_alliance_reservation = alliance.build_reservation({
        tag:       alliance.tag,
        name:      alliance.name,
        password:  params[:fundamental_alliance_reservation][:password]
      })
    else
      raise ForbiddenError.new('Acess denied.') unless staff?
      @fundamental_alliance_reservation = Fundamental::AllianceReservation.new(params[:fundamental_alliance_reservation])
    end

    respond_to do |format|
      if @fundamental_alliance_reservation.save
        format.html { redirect_to @fundamental_alliance_reservation, notice: 'Alliance reservation was successfully created.' }
        format.json { render json: @fundamental_alliance_reservation, status: :created, location: @fundamental_alliance_reservation }
      else
        format.html { render action: "new" }
        format.json { render json: @fundamental_alliance_reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/alliance_reservations/1
  # PUT /fundamental/alliance_reservations/1.json
  def update
    @fundamental_alliance_reservation = Fundamental::AllianceReservation.find(params[:id])

    unless staff?
      # check alliance
      raise ForbiddenError.new('Not member of alliance') unless @fundamental_alliance_reservation.alliance == current_character.alliance

      # check leader
      raise ForbiddenError.new('Not leader of alliance')  unless @fundamental_alliance_reservation.alliance.leader == current_character

      # set password if password is empty
      params[:fundamental_alliance_reservation][:password] = Util.make_random_string(6) if params[:fundamental_alliance_reservation][:password].blank?
    end

    respond_to do |format|
      if @fundamental_alliance_reservation.update_attributes(params[:fundamental_alliance_reservation])
        format.html { redirect_to @fundamental_alliance_reservation, notice: 'Alliance reservation was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_alliance_reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/alliance_reservations/1
  # DELETE /fundamental/alliance_reservations/1.json
  def destroy
    @fundamental_alliance_reservation = Fundamental::AllianceReservation.find(params[:id])
    @fundamental_alliance_reservation.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_alliance_reservations_url }
      format.json { head :ok }
    end
  end
end
