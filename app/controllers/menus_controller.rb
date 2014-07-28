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
    restaurant_assigned = true

    if current_user[:clientType] == Client::CLIENT_TYPES[:restaurator] || current_user[:clientType] == Client::CLIENT_TYPES[:administrator]
      if (@menu.restaurant_id == nil)
        restaurant_assigned = false
      end

    end

    respond_to do |format|
      if (restaurant_assigned)
        if @menu.save
          format.html { redirect_to @menu, notice: 'Menu was successfully created.' }
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

    restaurant_assigned = true

    if (@menu.restaurant_id == nil)
      restaurant_assigned = false
    end

    respond_to do |format|

      if (restaurant_assigned)
        if @menu.update_attributes(params[:menu])
          format.html { redirect_to @menu, notice: 'Menu was successfully updated.' }
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
