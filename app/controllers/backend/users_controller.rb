class Backend::UsersController < ApplicationController
  layout 'backend'
  
  before_filter :deny_api
  before_filter :authenticate_backend
  before_filter :authorize_staff

  
  # GET /backend/users
  # GET /backend/users.json
  def index
    @backend_users = Backend::User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @backend_users }
    end
  end

  # GET /backend/users/1
  # GET /backend/users/1.json
  def show
    @backend_user = Backend::User.find_by_id_or_login(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @backend_user }
    end
  end

  # GET /backend/users/new
  # GET /backend/users/new.json
  def new
    @backend_user = Backend::User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @backend_user }
    end
  end
  
  
  # create a new identity from the posted form data
  def create
    respond_to do |format|
      format.html {
        @backend_user = Backend::User.new(params[:backend_user], :as => :creator)
        @backend_user.deleted = false
      
        if @backend_user.save                                  # created successfully
#          IdentityMailer.validation_email(@identity).deliver  # send email validation email
          flash[:success] =    
            I18n.t('identities.signup.flash.welcome', :name => @backend_user.address_informal(:owner))
          redirect_to @backend_user                            # redirect to new user
        else 
          @title = I18n.t('identities.signup.title')
          render :new
        end
      }
    end
  end

  # edit an existing user
  def edit
    @backend_user = nil
#    bad_request = (name_blacklisted?(params[:id]) && !staff?) || !Backend::User.valid_user_identifier?(params[:id])
#    raise BadRequestError.new('Bad Request for Backend User %s' % params[:id]) if bad_request

    @backend_user = Backend::User.find_by_id_or_login(params[:id])
    raise NotFoundError.new('Page Not Found') if @backend_user.nil? || (@backend_user.deleted && !staff?)  # only staff can see deleted users
    
    role = current_backend_user ? current_backend_user.role : :default
    role = :owner if !admin? && current_backend_user && current_backend_user.id == @backend_user.id

    deny_access("You're not allowed to edit backend user %s." % params[:id]) unless role == :owner || staff?  

    @sanitized_backend_user = @backend_user.sanitized_hash(role)

    @accessible_attributes = Backend::User.accessible_attributes(role)
    
    @title = I18n.t('identities.edit.title')    
  end
  
  def update
    @backend_user = nil
  #  bad_request = (name_blacklisted?(params[:id]) && !staff?) || !Identity.valid_user_identifier?(params[:id])
  #  raise BadRequestError.new('Bad Request for Identity %s' % params[:id]) if bad_request

    @backend_user = Backend::User.find_by_id_or_login(params[:id])
    raise NotFoundError.new('Page Not Found') if @backend_user.nil? || (@backend_user.deleted && !staff?)  # only staff can see deleted users
    
    role = current_backend_user ? current_backend_user.role : :default
    role = :owner if !admin? && current_backend_user && current_backend_user.id == @backend_user.id

    deny_access("You're not allowed to edit backend user %s." % params[:id]) unless role == :owner || staff?  
              
    @backend_user.assign_attributes params[:backend_user].delete_if { |k,v| v.nil? }, :as => role
        
    if @backend_user.save
      redirect_to :action => "show"
    else
      flash[:error] = I18n.t('identities.update.flash.error', :name => @backend_user.address_informal)
      
      @sanitized_backend_user = @backend_user.sanitized_hash(role)
      @accessible_attributes = Backend::User.accessible_attributes(role) 
      
      render :action => "edit", :status => 500
    end
  end



  # disable an existing user
  def destroy
    if staff?
      @backend_user = Backend::User.find_by_id_or_login(params[:id])
    else
      if params[:id].to_i != current_backend_user.id
        flash[:error] = I18n.t('identities.delete.flash.error')
        @backend_user = Backend::User.find(params[:id])
        render :action => "show" and return      
      else
        @backend_user = current_backend_user
      end
    end
    
    @backend_user = Backend::User.find(params[:id])
    @backend_user.deleted = true
    @backend_user.save
    
    if params[:id].to_i != current_backend_user.id
      redirect_to :action => "index", :success => I18n.t('identities.delete.flash.success', :name => @backend_user.address_informal)
    else
      sign_out_with_backend
      redirect_to root_path, :success => I18n.t('identities.delete.flash.success', :name => @backend_user.address_informal)
    end
  end
end
