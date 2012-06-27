class Ranking::CharacterRankingsController < ApplicationController
  
  
  # GET /ranking/character_rankings
  # GET /ranking/character_rankings.json
  def index
    @ranking_character_rankings = Ranking::CharacterRanking.all

    respond_to do |format|
      format.html { render :layout => false }   # index.html.erb
      format.json { render json: @ranking_character_rankings }
    end
  end

  # GET /ranking/character_rankings/1
  # GET /ranking/character_rankings/1.json
  def show
    @ranking_character_ranking = Ranking::CharacterRanking.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ranking_character_ranking }
    end
  end

  # GET /ranking/character_rankings/new
  # GET /ranking/character_rankings/new.json
  def new
    @ranking_character_ranking = Ranking::CharacterRanking.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ranking_character_ranking }
    end
  end

  # GET /ranking/character_rankings/1/edit
  def edit
    @ranking_character_ranking = Ranking::CharacterRanking.find(params[:id])
  end

  # POST /ranking/character_rankings
  # POST /ranking/character_rankings.json
  def create
    @ranking_character_ranking = Ranking::CharacterRanking.new(params[:ranking_character_ranking])

    respond_to do |format|
      if @ranking_character_ranking.save
        format.html { redirect_to @ranking_character_ranking, notice: 'Character ranking was successfully created.' }
        format.json { render json: @ranking_character_ranking, status: :created, location: @ranking_character_ranking }
      else
        format.html { render action: "new" }
        format.json { render json: @ranking_character_ranking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ranking/character_rankings/1
  # PUT /ranking/character_rankings/1.json
  def update
    @ranking_character_ranking = Ranking::CharacterRanking.find(params[:id])

    respond_to do |format|
      if @ranking_character_ranking.update_attributes(params[:ranking_character_ranking])
        format.html { redirect_to @ranking_character_ranking, notice: 'Character ranking was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @ranking_character_ranking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ranking/character_rankings/1
  # DELETE /ranking/character_rankings/1.json
  def destroy
    @ranking_character_ranking = Ranking::CharacterRanking.find(params[:id])
    @ranking_character_ranking.destroy

    respond_to do |format|
      format.html { redirect_to ranking_character_rankings_url }
      format.json { head :ok }
    end
  end
end
