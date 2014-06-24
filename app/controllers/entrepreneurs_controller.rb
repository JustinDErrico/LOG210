class EntrepreneursController < ApplicationController
  # GET /entrepreneurs
  # GET /entrepreneurs.json
  def index
    @entrepreneurs = Entrepreneur.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entrepreneurs }
    end
  end

  # GET /entrepreneurs/1
  # GET /entrepreneurs/1.json
  def show
    @entrepreneur = Entrepreneur.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entrepreneur }
    end
  end

  # GET /entrepreneurs/new
  # GET /entrepreneurs/new.json
  def new
    @entrepreneur = Entrepreneur.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entrepreneur }
    end
  end

  # GET /entrepreneurs/1/edit
  def edit
    @entrepreneur = Entrepreneur.find(params[:id])
  end

  # POST /entrepreneurs
  # POST /entrepreneurs.json
  def create
    @entrepreneur = Entrepreneur.new(params[:entrepreneur])
    @entrepreneur.setAsEntrepreneur

    #valide si l'adresse email donnée existe déjà dans la BD
    if(Entrepreneur.find_all_by_emailAddress(@entrepreneur.emailAddress).empty?)

      #valide si le password équivaut à la confirmation du password
      if @entrepreneur.password.to_s() == @entrepreneur.password_confirmation.to_s()

        #hashage du password
        @entrepreneur.password = @entrepreneur.encrypt_password

        respond_to do |format|
          if @entrepreneur.save
            format.html { redirect_to @entrepreneur, notice: 'Entrepreneur was successfully created.' }
            format.json { render json: @entrepreneur, status: :created, location: @entrepreneur }
          else
            format.html { render action: "new" }
            format.json { render json: @entrepreneur.errors, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to new_entrepreneur_url, notice: 'Password Mismatch.' }
          format.json { render json: @entrepreneur, status: :precondition_failed, location: @entrepreneur }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to new_entrepreneur_url, notice: 'Email address already used by another user.' }
        format.json { render json: @entrepreneur, status: :precondition_failed, location: @entrepreneur }
      end
    end
  end

  # PUT /entrepreneurs/1
  # PUT /entrepreneurs/1.json
  def update
    @entrepreneur = Entrepreneur.find(params[:id])

    respond_to do |format|
      if @entrepreneur.update_attributes(params[:entrepreneur])
        format.html { redirect_to @entrepreneur, notice: 'Entrepreneur was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @entrepreneur.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entrepreneurs/1
  # DELETE /entrepreneurs/1.json
  def destroy
    @entrepreneur = Entrepreneur.find(params[:id])
    @entrepreneur.destroy

    respond_to do |format|
      format.html { redirect_to entrepreneurs_url }
      format.json { head :no_content }
    end
  end
end
