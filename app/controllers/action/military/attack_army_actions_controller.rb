class Action::Military::AttackArmyActionsController < ApplicationController
  # GET /action/military/attack_army_actions
  # GET /action/military/attack_army_actions.json
  def index
    @action_military_attack_army_actions = Action::Military::AttackArmyAction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @action_military_attack_army_actions }
    end
  end

  # GET /action/military/attack_army_actions/1
  # GET /action/military/attack_army_actions/1.json
  def show
    @action_military_attack_army_action = Action::Military::AttackArmyAction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @action_military_attack_army_action }
    end
  end

  # GET /action/military/attack_army_actions/new
  # GET /action/military/attack_army_actions/new.json
  def new
    @action_military_attack_army_action = Action::Military::AttackArmyAction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @action_military_attack_army_action }
    end
  end

  # GET /action/military/attack_army_actions/1/edit
  def edit
    @action_military_attack_army_action = Action::Military::AttackArmyAction.find(params[:id])
  end

  # POST /action/military/attack_army_actions
  # POST /action/military/attack_army_actions.json
  def create
    @action_military_attack_army_action = Action::Military::AttackArmyAction.new(params[:action_military_attack_army_action])

    respond_to do |format|
      if @action_military_attack_army_action.save
        format.html { redirect_to @action_military_attack_army_action, notice: 'Attack army action was successfully created.' }
        format.json { render json: @action_military_attack_army_action, status: :created, location: @action_military_attack_army_action }
      else
        format.html { render action: "new" }
        format.json { render json: @action_military_attack_army_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /action/military/attack_army_actions/1
  # PUT /action/military/attack_army_actions/1.json
  def update
    @action_military_attack_army_action = Action::Military::AttackArmyAction.find(params[:id])

    respond_to do |format|
      if @action_military_attack_army_action.update_attributes(params[:action_military_attack_army_action])
        format.html { redirect_to @action_military_attack_army_action, notice: 'Attack army action was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @action_military_attack_army_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /action/military/attack_army_actions/1
  # DELETE /action/military/attack_army_actions/1.json
  def destroy
    @action_military_attack_army_action = Action::Military::AttackArmyAction.find(params[:id])
    @action_military_attack_army_action.destroy

    respond_to do |format|
      format.html { redirect_to action_military_attack_army_actions_url }
      format.json { head :ok }
    end
  end
end
