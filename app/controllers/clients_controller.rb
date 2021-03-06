require 'digest/sha1'

class ClientsController < ApplicationController
skip_before_filter :require_login, :only => [:create,:new]
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

     if (session[:client_id] == nil)
       @client.address = params[:addresses][0]
     end

    respond_to do |format|
      #si la sauvegarde des informations dans la BD fonctionne
      if @client.save

        if (session[:client_id] == nil)
          @newAddress = ClientAddress.new
          @newAddress.address = params[:addresses][0]
          @newAddress.client_id = @client.id
          @newAddress.save
        end

        session[:client_type] = @client.clientType
        session[:client_id] = @client.id

        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render json: @client, status: :created, location: @client }
      else
        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /clients/1
  # PUT /clients/1.json
  def update
    @client = Client.find(params[:id])

    @AddressList = ClientAddress.find_all_by_client_id(current_user.id)
    @SortedAddressList = @AddressList.sort_by {|a| a.created_at}
    @SortedAddressList = @SortedAddressList.reverse!
    count = 0

    @SortedAddressList.each do |address|
      address.update_attribute(:address, params[:addresses][count].to_s)
      count = count + 1
    end
    respond_to do |format|
    if @client.update_attributes(params[:client])

        @client.update_attribute(:address, params[:addresses][0].to_s)

        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find(params[:id])

    if (@client.id == current_user.id)
      session[:client_id] = nil
      session[:client_type] = nil

      @client.destroy
      redirect_to root_url
    else
      @client.destroy
      respond_to do |format|
        format.html { redirect_to clients_url }
        format.json { head :no_content }
      end
    end
  end
end
