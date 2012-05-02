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
  

  
end
