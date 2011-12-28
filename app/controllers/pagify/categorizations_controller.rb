class Pagify::CategorizationsController < ApplicationController
  include Pagify::Controller

  # GET /pagify/categorizations
  # GET /pagify/categorizations.json
  def index
    @pagify_categorizations = Pagify::Categorization.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pagify_categorizations }
    end
  end

  # GET /pagify/categorizations/1
  # GET /pagify/categorizations/1.json
  def show
    @pagify_categorization = Pagify::Categorization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pagify_categorization }
    end
  end

  # GET /pagify/categorizations/new
  # GET /pagify/categorizations/new.json
  def new
    @pagify_categorization = Pagify::Categorization.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pagify_categorization }
    end
  end

  def new_for_category(category)
    @pagify_categorization = Pagify::Categorization.new
    @pagify_categorization.category = Category.find(category)


    respond_to do |format|
      format.html {render :template => :new }
      format.json { render json: @pagify_categorization }
    end
  end
  
  # GET /pagify/categorizations/1/edit
  def edit
    @pagify_categorization = Pagify::Categorization.find(params[:id])
  end

  # POST /pagify/categorizations
  # POST /pagify/categorizations.json
  def create
    @pagify_categorization = Pagify::Categorization.new(params[:pagify_categorization])

    respond_to do |format|
      if @pagify_categorization.save
        format.html {
          pagify_rdr_to_stored(pagify_categorizations_path)
          flash[:notice] = 'Categorization was successfully created.'
        }
        format.json { render json: @pagify_categorization, status: :created, location: @pagify_categorization }
      else
        format.html { render action: "new" }
        format.json { render json: @pagify_categorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pagify/categorizations/1
  # PUT /pagify/categorizations/1.json
  def update
    @pagify_categorization = Pagify::Categorization.find(params[:id])

    respond_to do |format|
      if @pagify_categorization.update_attributes(params[:pagify_categorization])
        format.html { redirect_to @pagify_categorization, notice: 'Categorization was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @pagify_categorization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pagify/categorizations/1
  # DELETE /pagify/categorizations/1.json
  def destroy
    @pagify_categorization = Pagify::Categorization.find(params[:id])
    @pagify_categorization.destroy

    respond_to do |format|
      format.html { redirect_to :back}
      format.json { head :ok }
    end
  end
end
