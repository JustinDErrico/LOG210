class RestauratorsController < ApplicationController
  # GET /restaurators
  # GET /restaurators.json
  def index
    @restaurators = Restaurator.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @restaurators }
    end
  end

  # GET /restaurators/1
  # GET /restaurators/1.json
  def show
    @restaurator = Restaurator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @restaurator }
    end
  end

  # GET /restaurators/new
  # GET /restaurators/new.json
  def new
    @restaurator = Restaurator.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @restaurator }
    end
  end

  # GET /restaurators/1/edit
  def edit
    @restaurator = Restaurator.find(params[:id])
  end

  # POST /restaurators
  # POST /restaurators.json
  def create
    @restaurator = Restaurator.new(params[:restaurator])
    @restaurator.setAsRestaurator

    respond_to do |format|
      if @restaurator.save
        format.html { redirect_to @restaurator, notice: 'Restaurator was successfully created.' }
        format.json { render json: @restaurator, status: :created, location: @restaurator }
      else
        format.html { render action: "new" }
        format.json { render json: @restaurator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /restaurators/1
  # PUT /restaurators/1.json
  def update
    @restaurator = Restaurator.find(params[:id])

    respond_to do |format|
      if @restaurator.update_attributes(params[:restaurator])
        format.html { redirect_to @restaurator, notice: 'Restaurator was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @restaurator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurators/1
  # DELETE /restaurators/1.json
  def destroy
    @restaurator = Restaurator.find(params[:id])
    @restaurator.destroy

    respond_to do |format|
      format.html { redirect_to restaurators_url }
      format.json { head :no_content }
    end
  end
end
