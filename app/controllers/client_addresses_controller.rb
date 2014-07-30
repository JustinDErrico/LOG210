class ClientAddressesController < ApplicationController
  # GET /client_addresses
  # GET /client_addresses.json
  def index
    @client_addresses = ClientAddress.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @client_addresses }
    end
  end

  # GET /client_addresses/1
  # GET /client_addresses/1.json
  def show
    @client_address = ClientAddress.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client_address }
    end
  end

  # GET /client_addresses/new
  # GET /client_addresses/new.json
  def new
    @client_address = ClientAddress.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client_address }
    end
  end

  # GET /client_addresses/1/edit
  def edit
    @client_address = ClientAddress.find(params[:id])
  end

  # POST /client_addresses
  # POST /client_addresses.json
  def create
    @client_address = ClientAddress.new(params[:client_address])

    respond_to do |format|
      if @client_address.save
        format.html { redirect_to @client_address, notice: 'Client address was successfully created.' }
        format.json { render json: @client_address, status: :created, location: @client_address }
      else
        format.html { render action: "new" }
        format.json { render json: @client_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /client_addresses/1
  # PUT /client_addresses/1.json
  def update
    @client_address = ClientAddress.find(params[:id])

    respond_to do |format|
      if @client_address.update_attributes(params[:client_address])
        format.html { redirect_to @client_address, notice: 'Client address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_addresses/1
  # DELETE /client_addresses/1.json
  def destroy
    @client_address = ClientAddress.find(params[:id])
    @client_address.destroy

    respond_to do |format|
      format.html { redirect_to client_addresses_url }
      format.json { head :no_content }
    end
  end
end
