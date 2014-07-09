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

    @restaurant_ids = Array.new
    restaurants_id_count = 0
    #valide si l'adresse email donnée existe déjà dans la BD
    if(Restaurator.find_all_by_emailAddress(@restaurator.emailAddress).empty?)

      #valide si le password équivaut à la confirmation du password
      if @restaurator.password.to_s() == @restaurator.password_confirmation.to_s()

        #hashage du password
        @restaurator.password = @restaurator.encrypt_password

        #sauvegarde des id des restaurants
        @restaurator.linkedRestaurant.each do |checkedRestaurant|
          if (checkedRestaurant != '0')
            @restaurant_ids.push(checkedRestaurant)
            restaurants_id_count = restaurants_id_count + 1
          end
        end

        #nombre de restaurants liés au restaurateur
        @restaurator.linkedRestaurant = restaurants_id_count

        respond_to do |format|
          if @restaurator.save

            #assignation des restaurants
            @restaurant_ids.each do |checkedRestaurant|

              @restaurant = Restaurant.find(checkedRestaurant)

              if(@restaurant != nil)
                @restaurant.update_attribute(:restaurator_id, @restaurator.id)
              end
            end

            format.html { redirect_to @restaurator, notice: 'Restaurator was successfully created.' }
            format.json { render json: @restaurator, status: :created, location: @restaurator }
          else
            format.html { render action: "new" }
            format.json { render json: @restaurator.errors, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to new_restaurator_url, notice: 'Password Mismatch.' }
          format.json { render json: @restaurator, status: :precondition_failed, location: @restaurator }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to new_restaurator_url, notice: 'Email address already used by another user.' }
        format.json { render json: @restaurator, status: :precondition_failed, location: @restaurator }
      end
    end
  end

  # PUT /restaurators/1
  # PUT /restaurators/1.json
  def update
    @restaurator = Restaurator.find(params[:id])
    temp_restaurator = Restaurator.new(params[:restaurator])

    if (temp_restaurator.linkedRestaurant != '')
      @restaurant = Restaurant.find(temp_restaurator.linkedRestaurant)

      if(@restaurant != nil)
        @restaurant.update_attribute(:restaurator_id, @restaurator.id)

      end
    end

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
