class Fundamental::RoundInfosController < ApplicationController
  layout 'fundamental'
  
  before_filter :authenticate
  before_filter :deny_api, :except => [:show]

  # GET /fundamental/round_infos/1
  # GET /fundamental/round_infos/1.json
  def show
    @fundamental_round_info = Fundamental::RoundInfo.find(1)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fundamental_round_info }
    end
  end

  # GET /fundamental/round_infos/1/edit
  def edit
    @fundamental_round_info = Fundamental::RoundInfo.find(1)
  end

  # PUT /fundamental/round_infos/1
  # PUT /fundamental/round_infos/1.json
  def update
    @fundamental_round_info = Fundamental::RoundInfo.find(1)

    respond_to do |format|
      if @fundamental_round_info.update_attributes(params[:fundamental_round_info])
        format.html { redirect_to @fundamental_round_info, notice: 'Round info was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fundamental_round_info.errors, status: :unprocessable_entity }
      end
    end
  end
end
