class ArchetypesController < ApplicationController
  # skip_before_action :authenticate, only: [:show, :index]
  before_action :set_archetype, only: %i[show edit update destroy]

  # GET /archetypes or /archetypes.json
  def index
    @archetypes = Archetype.all
  end

  # GET /archetypes/1 or /archetypes/1.json
  def show
  end

  # GET /archetypes/new
  def new
    @archetype = Archetype.new
  end

  # GET /archetypes/1/edit
  def edit
  end

  # POST /archetypes or /archetypes.json
  def create
    @archetype = Archetype.new(archetype_params)

    respond_to do |format|
      if @archetype.save
        format.html { redirect_to archetype_url(@archetype), notice: "Archetype was successfully created." }
        format.json { render :show, status: :created, location: @archetype }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @archetype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /archetypes/1 or /archetypes/1.json
  def update
    respond_to do |format|
      if @archetype.update(archetype_params)
        format.html { redirect_to archetype_url(@archetype), notice: "Archetype was successfully updated." }
        format.json { render :show, status: :ok, location: @archetype }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @archetype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /archetypes/1 or /archetypes/1.json
  def destroy
    @archetype.destroy!

    respond_to do |format|
      format.html { redirect_to archetypes_url, notice: "Archetype was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_archetype
    @archetype = Archetype.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def archetype_params
    # params.require(:archetype).permit(:title, :artist_credit_id, :archetypeable_type, :archetypeable_id)
    params.require(:archetype).permit(:title, :archetypeable_type, :archetypeable_id)
  end
end
