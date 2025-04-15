class ArtistCreditsController < ApplicationController
  # skip_before_action :authenticate, only: %i[show index]
  skip_before_action :require_authentication, only: %i[show index]
  before_action :set_artist_credit, only: %i[show edit update destroy]

  # GET /artist_credits or /artist_credits.json
  def index
    @artist_credits = ArtistCredit.all
  end

  # GET /artist_credits/1 or /artist_credits/1.json
  def show
  end

  # GET /artist_credits/new
  def new
    @artist_credit = ArtistCredit.new
  end

  # GET /artist_credits/1/edit
  def edit
  end

  # POST /artist_credits or /artist_credits.json
  def create
    @artist_credit = ArtistCredit.new(artist_credit_params)

    respond_to do |format|
      if @artist_credit.save
        format.html { redirect_to artist_credit_url(@artist_credit), notice: "Artist credit was successfully created." }
        format.json { render :show, status: :created, location: @artist_credit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @artist_credit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /artist_credits/1 or /artist_credits/1.json
  def update
    respond_to do |format|
      if @artist_credit.update(artist_credit_params)
        format.html { redirect_to artist_credit_url(@artist_credit), notice: "Artist credit was successfully updated." }
        format.json { render :show, status: :ok, location: @artist_credit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @artist_credit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artist_credits/1 or /artist_credits/1.json
  def destroy
    @artist_credit.destroy!

    respond_to do |format|
      format.html { redirect_to artist_credits_url, notice: "Artist credit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_artist_credit
    @artist_credit = ArtistCredit.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def artist_credit_params
    params.require(:artist_credit).permit(:name)
  end
end
