class PlatsController < ApplicationController
  # GET /plats
  # GET /plats.json
  def index
    @plats = Plat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plats }
    end
  end

  # GET /plats/1
  # GET /plats/1.json
  def show
    @plat = Plat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plat }
    end
  end

  # GET /plats/new
  # GET /plats/new.json
  def new
    @plat = Plat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plat }
    end
  end

  # GET /plats/1/edit
  def edit
    @plat = Plat.find(params[:id])
  end

  # POST /plats
  # POST /plats.json
  def create
    @plat = Plat.new(params[:plat])

    respond_to do |format|
      if @plat.save
        format.html { redirect_to @plat, notice: 'Plat was successfully created.' }
        format.json { render json: @plat, status: :created, location: @plat }
      else
        format.html { render action: "new" }
        format.json { render json: @plat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /plats/1
  # PUT /plats/1.json
  def update
    @plat = Plat.find(params[:id])

    respond_to do |format|
      if @plat.update_attributes(params[:plat])
        format.html { redirect_to @plat, notice: 'Plat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @plat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plats/1
  # DELETE /plats/1.json
  def destroy
    @plat = Plat.find(params[:id])
    @plat.destroy

    respond_to do |format|
      format.html { redirect_to plats_url }
      format.json { head :no_content }
    end
  end
end
