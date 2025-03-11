class EditionSectionsController < ApplicationController
  skip_before_action :authenticate, only: %i[ index show ]
  before_action :set_edition_section, only: %i[ show edit update destroy ]

  # GET /edition_sections or /edition_sections.json
  def index
    @edition_sections = EditionSection.all
  end

  # GET /edition_sections/1 or /edition_sections/1.json
  def show
  end

  # GET /edition_sections/new
  def new
    @edition_section = EditionSection.new
  end

  # GET /edition_sections/1/edit
  def edit
  end

  # POST /edition_sections or /edition_sections.json
  def create
    @edition_section = EditionSection.new(edition_section_params)

    respond_to do |format|
      if @edition_section.save
        format.html { redirect_to @edition_section, notice: "Edition section was successfully created." }
        format.json { render :show, status: :created, location: @edition_section }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @edition_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /edition_sections/1 or /edition_sections/1.json
  def update
    respond_to do |format|
      if @edition_section.update(edition_section_params)
        format.html { redirect_to @edition_section, notice: "Edition section was successfully updated." }
        format.json { render :show, status: :ok, location: @edition_section }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @edition_section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /edition_sections/1 or /edition_sections/1.json
  def destroy
    @edition_section.destroy!

    respond_to do |format|
      format.html { redirect_to edition_sections_path, status: :see_other, notice: "Edition section was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_edition_section
      @edition_section = EditionSection.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def edition_section_params
      params.expect(edition_section: [ :alphanumeric, :level, :no, :edition_id, :positions_count ])
    end
end
