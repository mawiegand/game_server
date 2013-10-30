class Facebook::ObjectTypesController < ApplicationController
  layout 'facebook'

  # GET /facebook/object_types
  # GET /facebook/object_types.json
  def index
    @facebook_user_stories = GameRules::Rules.the_rules.facebook_user_stories

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @facebook_user_stories }
    end
  end

  # GET /facebook/object_types/1
  # GET /facebook/object_types/1.json
  def show
    @facebook_user_story = GameRules::Rules.the_rules.facebook_user_stories[params[:id].to_i]
    raise NotFoundError.new('User story not found.') if @facebook_user_story.nil?

    @facebook_app_id = Facebook::AppConfig.the_app_config.app_id

    respond_to do |format|
      format.html { render layout: 'empty' }
      format.json { render json: @facebook_user_story }
    end
  end

end
