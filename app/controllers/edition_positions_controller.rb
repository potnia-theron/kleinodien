class EditionPositionsController < ApplicationController
  # skip_before_action :authenticate, only: %i[index show]
  before_action :set_edition_position, only: %i[show edit update destroy]

  # GET /edition_positions or /edition_positions.json
  def index
    @edition_positions = EditionPosition.all
  end

  # GET /edition_positions/1 or /edition_positions/1.json
  def show
  end

  # GET /edition_positions/new
  def new
    @edition_position = EditionPosition.new
  end

  # GET /edition_positions/1/edit
  def edit
  end

  # POST /edition_positions or /edition_positions.json
  def create
    @edition_position = EditionPosition.new(edition_position_params)

    respond_to do |format|
      if @edition_position.save
        format.html { redirect_to @edition_position, notice: "Edition position was successfully created." }
        format.json { render :show, status: :created, location: @edition_position }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @edition_position.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /edition_positions/1 or /edition_positions/1.json
  def update
    respond_to do |format|
      if @edition_position.update(edition_position_params)
        format.html { redirect_to @edition_position, notice: "Edition position was successfully updated." }
        format.json { render :show, status: :ok, location: @edition_position }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @edition_position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /edition_positions/1 or /edition_positions/1.json
  def destroy
    @edition_position.destroy!

    respond_to do |format|
      format.html { redirect_to edition_positions_path, status: :see_other, notice: "Edition position was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_edition_position
    @edition_position = EditionPosition.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def edition_position_params
    params.expect(edition_position: [:alphanumeric, :no, :edition_id, :edition_section_id])
  end
end
