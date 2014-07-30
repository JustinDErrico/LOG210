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
      @commande.deliveryAddress = current_user.address
    end
    
    if @commande.save
      params['produits'].each do |p|
        if p[1][:quantity].to_f > 0

          @produit = Produit.new(commande_id: @commande.id, plat_id: p[1][:plat_id], quantity: p[1][:quantity])

          if !@produit.save
            valid = false
          end
        end
      end
    end

    respond_to do |format|
      if valid
        format.html { render 'commandes/confirmation', notice: 'Commande was successfully added.' }
      else
        format.html { render action: "new", notice: 'Erreur dans la commande' }
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

  def confirmer
    @commande = Commande.find(params[:id])
    no_confirmation = Digest::SHA1.hexdigest([Time.now, rand].join)

    finalAddress = params[:SelectedAddress]

    if (params[:NewAddress] != '')
      finalAddress = params[:NewAddress]

      @NewClientAddress = ClientAddress.new
      @NewClientAddress.address = finalAddress
      @NewClientAddress.client_id = current_user.id
      @NewClientAddress.save

      Client.find(current_user.id).update_attribute(:address, finalAddress)
    end

    respond_to do |format|
      dateformat = "%d/%m/%Y %H:%M"
      if @commande.update_attributes(:deliveryTime => DateTime.strptime(params[:deliveryTime], dateformat), :deliveryAddress => finalAddress)
        format.html { redirect_to @commande, notice: 'Commande was successfully updated. Numero de confirmation: '+ no_confirmation}
        format.json { head :no_content }
      end
    end
  end
end