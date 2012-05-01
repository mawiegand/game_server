class Backend::UsersController < ApplicationController
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
    @backend_user = Backend::User.find(params[:id])

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

  # GET /backend/users/1/edit
  def edit
    @backend_user = Backend::User.find(params[:id])
  end

  # POST /backend/users
  # POST /backend/users.json
  def create
    @backend_user = Backend::User.new(params[:backend_user])

    respond_to do |format|
      if @backend_user.save
        format.html { redirect_to @backend_user, notice: 'User was successfully created.' }
        format.json { render json: @backend_user, status: :created, location: @backend_user }
      else
        format.html { render action: "new" }
        format.json { render json: @backend_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /backend/users/1
  # PUT /backend/users/1.json
  def update
    @backend_user = Backend::User.find(params[:id])

    respond_to do |format|
      if @backend_user.update_attributes(params[:backend_user])
        format.html { redirect_to @backend_user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @backend_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /backend/users/1
  # DELETE /backend/users/1.json
  def destroy
    @backend_user = Backend::User.find(params[:id])
    @backend_user.destroy

    respond_to do |format|
      format.html { redirect_to backend_users_url }
      format.json { head :ok }
    end
  end
end
