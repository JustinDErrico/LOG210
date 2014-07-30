class MenusController < ApplicationController
  # GET /menus
  # GET /menus.json
  def index
    @menus = Menu.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @menus }
    end
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
    @menu = Menu.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @menu }
    end
  end

  # GET /menus/new
  # GET /menus/new.json
  def new
    @menu = Menu.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @menu }
    end
  end

  # GET /menus/1/edit
  def edit
    @menu = Menu.find(params[:id])
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(params[:menu])

    notice = 'Menu was successfully created.'

    params.each do |key, value| 
      if key.to_s == 'description'
        if param[key].blank?
          notice = 'Vous avez ajouté un plat sans lui assigner une description.'
        end
      end
    end

    restaurant_assigned = true

    # if current_user[:clientType] == Client::CLIENT_TYPES[:restaurator] || current_user[:clientType] == Client::CLIENT_TYPES[:administrator]
    #   if (@menu.restaurant_id == nil)
    #     restaurant_assigned = false
    #   end
    # end

    respond_to do |format|
      if (restaurant_assigned)
        if @menu.save
          format.html { redirect_to @menu, notice: notice }
          format.json { render json: @menu, status: :created, location: @menu }
        else
          format.html { render action: "new" }
          format.json { render json: @menu.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to new_menu_path, notice: 'No restaurant is assigned.' }
        format.json { render json: @menu, status: :created, location: @menu }
      end
    end
  end

  # PUT /menus/1
  # PUT /menus/1.json
  def update
    @menu = Menu.find(params[:id])

    notice = 'Menu was successfully updated.'

    puts "params" + params.to_yaml

    # if nested_hash_value(params, :description).empty
    #   notice = 'Vous avez modifié un plat sans lui assigner une description.'
    # end

    params[:menu][:plats_attributes].each do |key, value|
      value.each do |s_key, s_value|
        if s_key.to_s == 'description' && s_value.to_s == ''
          notice = 'Vous avez modifié un plat sans lui assigner une description.'
          puts "val" + s_value.to_yaml
        end
      end
    end

    restaurant_assigned = true

    if (@menu.restaurant_id == nil)
      restaurant_assigned = false
    end

    respond_to do |format|

      if (restaurant_assigned)
        if @menu.update_attributes(params[:menu])
          format.html { redirect_to @menu, notice: notice }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @menu.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to edit_menu_path, notice: 'No restaurant is assigned.' }
        format.json { render json: @menu, status: :created, location: @menu }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to menus_url }
      format.json { head :no_content }
    end
  end
end