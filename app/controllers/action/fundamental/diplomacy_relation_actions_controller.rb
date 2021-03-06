class Action::Fundamental::DiplomacyRelationActionsController < ApplicationController
  layout 'action'

  before_filter :authenticate

  def create

    raise BadRequestError.new('no current character') if current_character.nil?
    raise BadRequestError.new('missing parameter(s)') if params[:diplomacy_relation_action].nil? ||
                                                         params[:diplomacy_relation_action][:source_alliance_id].blank? ||
                                                         params[:diplomacy_relation_action][:target_alliance_name].blank? ||
                                                         params[:diplomacy_relation_action][:new_relation].blank?

    raise ForbiddenError.new('tried to do an alliance action although not even in an alliance') if current_character.alliance_id.blank?
    raise ForbiddenError.new('tried to change setting on wrong alliance') unless current_character.alliance_id == params[:diplomacy_relation_action][:source_alliance_id].to_i
    raise ForbiddenError.new('only leader can change diplomacy relations') unless current_character.alliance_leader?
    
    target_alliance = Fundamental::Alliance.find_by_tag_or_name(params[:diplomacy_relation_action][:target_alliance_name])

    raise NotFoundError.new('Could not find target alliance!') if target_alliance.nil?
    raise ForbiddenError.new('tried to create diplomacy relation with own alliance') if current_character.alliance_id == target_alliance.id

    if params[:diplomacy_relation_action][:new_relation] != "1" # if requested for status change
      raise ForbiddenError.new('missing relation id for manual status change') if params[:diplomacy_relation_action][:id].blank? && params[:diplomacy_relation_action][:relation_action_id].blank?

      if !params[:diplomacy_relation_action][:relation_action_id].blank?
        diplomacy_relation = Fundamental::DiplomacyRelation.find(params[:diplomacy_relation_action][:relation_action_id])
      else
        diplomacy_relation = Fundamental::DiplomacyRelation.find(params[:diplomacy_relation_action][:id])
      end
      
      raise NotFoundError.new("relation with id #{params[:diplomacy_relation_action][:id]} not found") if diplomacy_relation.nil?
      raise ConflictError.new('tried to change foreign relation') if current_character.alliance_id != params[:diplomacy_relation_action][:source_alliance_id].to_i

      if diplomacy_relation.is_manual_status_change_allowed?
        diplomacy_relation.next_status(true)
      else
        raise ForbiddenError.new('manual status change of diplomacy relation is not allowed')
      end
    else # if requested for new relation
      diplomacy_relations = current_character.alliance.diplomacy_source_relations.where(target_alliance_id: target_alliance.id)
      raise ConflictError.new('relation between alliance already exists') if diplomacy_relations.present?

      relation = Fundamental::DiplomacyRelation.new(source_alliance_id: current_character.alliance_id,
                                           target_alliance_id: target_alliance.id,
                                           diplomacy_status: 5,
                                           initiator: true
                                           )
      raise BadRequestError.new('creating diplomacy relation failed') unless relation.save
      raise BadRequestError.new('creating diplomacy relation copy failed') unless relation.create_inverse_relation(relation.diplomacy_status)
    end

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
