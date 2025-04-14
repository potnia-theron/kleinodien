class LinkKindsController < ApplicationController
  # skip_before_action :authenticate, only: %i[index show]
  before_action :set_link_kind, only: %i[show edit update destroy]

  # GET /link_kinds or /link_kinds.json
  def index
    @link_kinds = LinkKind.all
  end

  # GET /link_kinds/1 or /link_kinds/1.json
  def show
  end

  # GET /link_kinds/new
  def new
    @link_kind = LinkKind.new
  end

  # GET /link_kinds/1/edit
  def edit
  end

  # POST /link_kinds or /link_kinds.json
  def create
    @link_kind = LinkKind.new(link_kind_params)

    respond_to do |format|
      if @link_kind.save
        format.html { redirect_to @link_kind, notice: "Link kind was successfully created." }
        format.json { render :show, status: :created, location: @link_kind }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @link_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /link_kinds/1 or /link_kinds/1.json
  def update
    respond_to do |format|
      if @link_kind.update(link_kind_params)
        format.html { redirect_to @link_kind, notice: "Link kind was successfully updated." }
        format.json { render :show, status: :ok, location: @link_kind }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @link_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /link_kinds/1 or /link_kinds/1.json
  def destroy
    @link_kind.destroy!

    respond_to do |format|
      format.html { redirect_to link_kinds_path, status: :see_other, notice: "Link kind was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_link_kind
    @link_kind = LinkKind.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def link_kind_params
    params.expect(link_kind: [:name, :description, :link_phrase, :reverse_link_phrase, :long_link_phrase, :musicbrainz_code])
  end
end
