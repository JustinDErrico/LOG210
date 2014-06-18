require 'digest/sha1'

class ClientsController < ApplicationController

  # GET /clients
  # GET /clients.json


  def index
    @clients = Client.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.json
  def new
    @client = Client.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
  end

  # POST /clients
  # POST /clients.json
  def create
    #le client possédant les informations entrées par l'utilisateur (pas encore sauvegardé dans la BD)
    @client = Client.new(params[:client])
    @client.setAsVisitor
    #valide si l'adresse email donnée existe déjà dans la BD
    if(Client.find_all_by_emailAddress(@client.emailAddress).empty?)

      #valide si le password équivaut à la confirmation du password
      if @client.password.to_s() == @client.password_confirmation.to_s()

        #hashage du password
        @client.password = @client.encrypt_password

        respond_to do |format|
          #si la sauvegarde des informations dans la BD fonctionne
          if @client.save
            format.html { redirect_to @client, notice: 'Client was successfully created.' }
            format.json { render json: @client, status: :created, location: @client }
          else
            format.html { render action: "new" }
            format.json { render json: @client.errors, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to new_client_url, notice: 'Password Mismatch.' }
          format.json { render json: @client, status: :precondition_failed, location: @client }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to new_client_url, notice: 'Email address already used by another user.' }
        format.json { render json: @client, status: :precondition_failed, location: @client }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.json
  def update
    @client = Client.find(params[:id])
    temp_client = Client.new(params[:client])

    respond_to do |format|
      if temp_client.password.to_s == temp_client.password_confirmation.to_s
        temp_client.password = Digest::SHA1.hexdigest(temp_client.password)

        if @client.update_attributes(params[:client])

          if @client.update_attribute(:password, temp_client.password)
            format.html { redirect_to @client, notice: 'Client was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @client.errors, status: :unprocessable_entity }
          end
        end

      else
        format.html { redirect_to '/clients/' + @client.id.to_s + '/edit', notice: 'Password mismatch.' }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end
end
