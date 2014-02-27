class Fundamental::AllianceLeaderVotesController < ApplicationController
  # GET /fundamental/alliance_leader_votes
  # GET /fundamental/alliance_leader_votes.json
  def index
    @fundamental_alliance_leader_votes = Fundamental::AllianceLeaderVote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fundamental_alliance_leader_votes }
    end
  end

  # GET /fundamental/alliance_leader_votes/1
  # GET /fundamental/alliance_leader_votes/1.json
  def show
    @fundamental_alliance_leader_vote = Fundamental::AllianceLeaderVote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_alliance_leader_vote }
    end
  end

  # GET /fundamental/alliance_leader_votes/new
  # GET /fundamental/alliance_leader_votes/new.json
  def new
    @fundamental_alliance_leader_vote = Fundamental::AllianceLeaderVote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fundamental_alliance_leader_vote }
    end
  end

  # GET /fundamental/alliance_leader_votes/1/edit
  def edit
    @fundamental_alliance_leader_vote = Fundamental::AllianceLeaderVote.find(params[:id])
  end

  # POST /fundamental/alliance_leader_votes
  # POST /fundamental/alliance_leader_votes.json
  def create
    @fundamental_alliance_leader_vote = Fundamental::AllianceLeaderVote.new(params[:fundamental_alliance_leader_vote])

    respond_to do |format|
      if @fundamental_alliance_leader_vote.save
        format.html { redirect_to @fundamental_alliance_leader_vote, notice: 'Alliance leader vote was successfully created.' }
        format.json { render json: @fundamental_alliance_leader_vote, status: :created, location: @fundamental_alliance_leader_vote }
      else
        format.html { render action: "new" }
        format.json { render json: @fundamental_alliance_leader_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fundamental/alliance_leader_votes/1
  # PUT /fundamental/alliance_leader_votes/1.json
  def update
    @fundamental_alliance_leader_vote = Fundamental::AllianceLeaderVote.find(params[:id])

    respond_to do |format|
      if @fundamental_alliance_leader_vote.update_attributes(params[:fundamental_alliance_leader_vote])
        format.html { redirect_to @fundamental_alliance_leader_vote, notice: 'Alliance leader vote was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_alliance_leader_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundamental/alliance_leader_votes/1
  # DELETE /fundamental/alliance_leader_votes/1.json
  def destroy
    @fundamental_alliance_leader_vote = Fundamental::AllianceLeaderVote.find(params[:id])
    @fundamental_alliance_leader_vote.destroy

    respond_to do |format|
      format.html { redirect_to fundamental_alliance_leader_votes_url }
      format.json { head :ok }
    end
  end
end
