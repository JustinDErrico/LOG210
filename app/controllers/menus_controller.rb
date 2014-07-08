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

    if current_user[:clientType] == Client::CLIENT_TYPES[:restaurator]
      @restaurant = Restaurant.find_by_restaurator_id(current_user[:id])
      if @restaurant != nil
        @menu.restaurant_id = @restaurant.id
      end
    end

    if !@menu[:name].nil?
      respond_to do |format|
        if @menu.save
          format.html { redirect_to @menu, notice: 'Menu was successfully created.' }
          format.json { render json: @menu, status: :created, location: @menu }
        else
          format.html { render action: "new" }
          format.json { render json: @menu.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to new_menu_url, notice: 'Name cannot be empty.' }
        format.json { render json: @menu, status: :precondition_failed, location: @menu }
      end
    end
  end

  # PUT /menus/1
  # PUT /menus/1.json
  def update
    @menu = Menu.find(params[:id])

    respond_to do |format|
      if @menu.update_attributes(params[:menu])
        format.html { redirect_to @menu, notice: 'Menu was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
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
