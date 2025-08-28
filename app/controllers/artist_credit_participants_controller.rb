class ArtistCreditParticipantsController < ApplicationController
  skip_before_action :require_authentication, only: %i[show index]
  before_action :set_artist_credit_participant, only: %i[show edit update destroy]

  # GET /artist_credit_participants or /artist_credit_participants.json
  def index
    @artist_credit_participants = ArtistCreditParticipant.all
  end

  # GET /artist_credit_participants/1 or /artist_credit_participants/1.json
  def show
  end

  # GET /artist_credit_participants/new
  def new
    @artist_credit_participant = ArtistCreditParticipant.new
  end

  # GET /artist_credit_participants/1/edit
  def edit
  end

  # POST /artist_credit_participants or /artist_credit_participants.json
  def create
    @artist_credit_participant = ArtistCreditParticipant.new(artist_credit_participant_params)

    respond_to do |format|
      if @artist_credit_participant.save
        format.html { redirect_to artist_credit_participant_url(@artist_credit_participant), notice: "Artist credit participant was successfully created." }
        format.json { render :show, status: :created, location: @artist_credit_participant }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @artist_credit_participant.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /artist_credit_participants/1 or /artist_credit_participants/1.json
  def update
    respond_to do |format|
      if @artist_credit_participant.update(artist_credit_participant_params)
        format.html { redirect_to artist_credit_participant_url(@artist_credit_participant), notice: "Artist credit participant was successfully updated." }
        format.json { render :show, status: :ok, location: @artist_credit_participant }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @artist_credit_participant.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /artist_credit_participants/1 or /artist_credit_participants/1.json
  def destroy
    @artist_credit_participant.destroy!

    respond_to do |format|
      format.html { redirect_to artist_credit_participants_url, notice: "Artist credit participant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_artist_credit_participant
    @artist_credit_participant = ArtistCreditParticipant.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def artist_credit_participant_params
    params.require(:artist_credit_participant).permit(:artist_credit_id, :join_phrase, :participant_id, :position)
  end
end
