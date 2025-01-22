class MusicbrainzImportOrdersController < ApplicationController
  before_action :set_musicbrainz_import_order, only: %i[show edit update destroy]

  # GET /musicbrainz_import_orders or /musicbrainz_import_orders.json
  def index
    @musicbrainz_import_orders = current_user.musicbrainz_import_orders
  end

  # GET /musicbrainz_import_orders/1 or /musicbrainz_import_orders/1.json
  def show
  end

  # GET /musicbrainz_import_orders/new
  def new
    @musicbrainz_import_order = current_user.musicbrainz_import_orders.build
  end

  # GET /musicbrainz_import_orders/1/edit
  def edit
  end

  # POST /musicbrainz_import_orders or /musicbrainz_import_orders.json
  def create
    @musicbrainz_import_order = current_user.musicbrainz_import_orders.build(musicbrainz_import_order_params)

    respond_to do |format|
      if @musicbrainz_import_order.save
        format.html { redirect_to musicbrainz_import_order_url(@musicbrainz_import_order), notice: "Music brainz import order was successfully created." }
        format.json { render :show, status: :created, location: @musicbrainz_import_order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @musicbrainz_import_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /musicbrainz_import_orders/1 or /musicbrainz_import_orders/1.json
  def update
    respond_to do |format|
      if @musicbrainz_import_order.update(musicbrainz_import_order_params)
        format.html { redirect_to musicbrainz_import_order_url(@musicbrainz_import_order), notice: "Music brainz import order was successfully updated." }
        format.json { render :show, status: :ok, location: @musicbrainz_import_order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @musicbrainz_import_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /musicbrainz_import_orders/1 or /musicbrainz_import_orders/1.json
  def destroy
    @musicbrainz_import_order.destroy

    respond_to do |format|
      format.html { redirect_to musicbrainz_import_orders_url, notice: "Music brainz import order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_musicbrainz_import_order
    @musicbrainz_import_order = MusicbrainzImportOrder.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def musicbrainz_import_order_params
    # params.fetch(:musicbrainz_import_order, {})
    params.require(:musicbrainz_import_order).permit(:code, :kind, :state, :type, :uri, :import_order_id, :user_id)
  end
end
