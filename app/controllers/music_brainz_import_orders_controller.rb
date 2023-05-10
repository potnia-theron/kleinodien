class MusicBrainzImportOrdersController < ApplicationController
  before_action :set_music_brainz_import_order, only: %i[ show edit update destroy ]

  # GET /music_brainz_import_orders or /music_brainz_import_orders.json
  def index
    @music_brainz_import_orders = current_user.music_brainz_import_orders
  end

  # GET /music_brainz_import_orders/1 or /music_brainz_import_orders/1.json
  def show
  end

  # GET /music_brainz_import_orders/new
  def new
    @music_brainz_import_order = current_user.music_brainz_import_orders.build
  end

  # GET /music_brainz_import_orders/1/edit
  def edit
  end

  # POST /music_brainz_import_orders or /music_brainz_import_orders.json
  def create
    @music_brainz_import_order = current_user.music_brainz_import_orders.build(music_brainz_import_order_params)

    respond_to do |format|
      if @music_brainz_import_order.save
        format.html { redirect_to music_brainz_import_order_url(@music_brainz_import_order), notice: "Music brainz import order was successfully created." }
        format.json { render :show, status: :created, location: @music_brainz_import_order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @music_brainz_import_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /music_brainz_import_orders/1 or /music_brainz_import_orders/1.json
  def update
    respond_to do |format|
      if @music_brainz_import_order.update(music_brainz_import_order_params)
        format.html { redirect_to music_brainz_import_order_url(@music_brainz_import_order), notice: "Music brainz import order was successfully updated." }
        format.json { render :show, status: :ok, location: @music_brainz_import_order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @music_brainz_import_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /music_brainz_import_orders/1 or /music_brainz_import_orders/1.json
  def destroy
    @music_brainz_import_order.destroy

    respond_to do |format|
      format.html { redirect_to music_brainz_import_orders_url, notice: "Music brainz import order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_music_brainz_import_order
    @music_brainz_import_order = MusicBrainzImportOrder.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def music_brainz_import_order_params
    # params.fetch(:music_brainz_import_order, {})
    params.require(:music_brainz_import_order).permit(:code, :kind, :state, :type, :uri, :import_order_id, :user_id)
  end
end
