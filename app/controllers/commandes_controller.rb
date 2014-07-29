class CommandesController < ApplicationController
  # GET /commandes
  # GET /commandes.json
  def index
    @commandes = Commande.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @commandes }
    end
  end

  # GET /commandes/1
  # GET /commandes/1.json
  def show
    @commande = Commande.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @commande }
    end
  end

  # GET /commandes/new
  # GET /commandes/new.json
  def new
    @commande = Commande.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @commande }
    end
  end

  # GET /commandes/1/edit
  def edit
    @commande = Commande.find(params[:id])
  end

  # POST /commandes
  # POST /commandes.json
  def create
    valid = true
    @commande = Commande.new(params[:commande])

    if (current_user.clientType == Client::CLIENT_TYPES[:visitor])
      @commande.client_id = current_user.id
    end
    
    if @commande.save
      params['produits'].each do |p|
        @produit = Produit.new(commande_id: @commande.id, plat_id: p[1][:plat_id], quantity: p[1][:quantity])

        if !@produit.save
          puts "produit--------" + @produit.to_yaml
          valid = false
        end
      end
    end

    respond_to do |format|
      if valid
        format.html { redirect_to @commande, notice: 'Commande was successfully added.' }
      else
        format.html { render action: "new", notice: 'Erreur' }
      end
    end
  end

  # PUT /commandes/1
  # PUT /commandes/1.json
  def update
    @commande = Commande.find(params[:id])

    respond_to do |format|
      if @commande.update_attributes(params[:commande])
        format.html { redirect_to @commande, notice: 'Commande was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @commande.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commandes/1
  # DELETE /commandes/1.json
  def destroy
    @commande = Commande.find(params[:id])
    @commande.destroy

    respond_to do |format|
      format.html { redirect_to commandes_url }
      format.json { head :no_content }
    end
  end

  def get_menus
    respond_to do |format|
      format.js { render :partial => 'commandes/passer_commande', :locals => { :restaurant_id => params[:id] } }
    end
  end
end
