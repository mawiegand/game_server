module ApplicationHelper
  
  # This is a snippet from "Restful web services" to realize conditional get by a simple 
  # wrapper that can be used in every request. Needs RFC compliant if_modified_since.
  #
  #  curl -v -H "if_modified_since: Mon, 05 Mar 2012 23:58:08 GMT" localhost:3000/map/nodes/1.json
  def render_not_modified_or(last_modified)
    response.headers['Last-Modified'] = last_modified.httpdate if last_modified
    
    if_modified_since = request.env['HTTP_IF_MODIFIED_SINCE']
    
    if if_modified_since && last_modified && last_modified <= Time.httpdate(if_modified_since)  
      # has not changed
      render :nothing => true, :status => '304 Not Modified'
    else
      # has changed -> proceed with output processing
      yield
    end
  end
  
  def if_modified_since_time
    return @if_modified_since_time    unless @if_modified_since_time.blank?
    
    if_modified_since       = request.env['HTTP_IF_MODIFIED_SINCE']    
    @if_modified_since_time = if_modified_since.blank? ? nil : Time.httpdate(if_modified_since)  
  end

  
  # creates the gravatar image tag with the side-wide default values.
  # Tag-Class and options may be overwritten by passing-in differing
  # values. 
  #
  # Possible options include (visit Gravatar for complete list):
  # [:size]    size of the created image
  # [:default] which default-icon to use, when user is not registered
  #            with gravatar (see Gravatar API for values)
  def gravatar_for(identity, css_class = 'gravatar', options = {})
    
    options = { 
      :size => 100, 
      :default => :identicon 
    }.merge(options).delete_if { |key, value| value.nil? }  # merge 'over' default values
    
    gravatar_image_tag(identity.email.strip.downcase, :alt      => identity.nickname,
                                                      :class    => css_class,
                                                      :gravatar => options )
  end
  
  def gravatar_img_tag_for(url, options = {})
    options = { 
      :class => 'gravatar',
      :alt => 'Gravatar',
      :src => url
    }.merge(options).delete_if { |key, value| value.nil? }  # merge 'over' default values
    
    tag 'img', options, false, false # Patch submitted to rails to allow image_tag here https://rails.lighthouseapp.com/projects/8994/tickets/2878-image_tag-doesnt-allow-escape-false-option-anymore   
  end
  

  
end
