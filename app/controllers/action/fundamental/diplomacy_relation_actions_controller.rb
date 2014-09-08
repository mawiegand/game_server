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
    
    if target_alliance.nil?
      raise NotFoundError.new('Could not find target alliance!')
    else
      raise ForbiddenError.new('tried to create diplomacy relation with own alliance') if current_character.alliance_id == target_alliance.id.to_i
      diplomacy_relations = current_character.alliance.diplomacy_source_relations.where(target_alliance_id: target_alliance.id)
      if diplomacy_relations.present?
        raise ConflictError.new('relation between alliance already exists') if (params[:diplomacy_relation_action][:new_relation] == "1")
        
        if diplomacy_relations.first.is_manual_status_change_allowed?
          diplomacy_relations.first.next_status
        else
          raise ForbiddenError.new('manual status change of diplomacy relation is not allowed')
        end
      else
        relation = Fundamental::DiplomacyRelation.new(source_alliance_id: current_character.alliance_id,
                                             target_alliance_id: target_alliance.id,
                                             diplomacy_status: 1,
                                             initiator: true
                                             )
        raise BadRequestError.new('creating diplomacy relation failed') unless relation.save
        raise BadRequestError.new('creating diplomacy relation copy failed') unless relation.create_copy(relation.diplomacy_status)
      end
    end

    respond_to do |format|
      format.json { render json: {}, status: :ok }
    end
  end
  
end
