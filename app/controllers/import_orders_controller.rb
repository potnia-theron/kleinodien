class ImportOrdersController < ApplicationController
  before_action :set_import_order, only: %i[show edit update destroy]
  after_action :place_job, only: %i[create]

  # GET /import_orders or /import_orders.json
  def index
    @import_orders = Current.user.import_orders
  end

  # GET /import_orders/1 or /import_orders/1.json
  def show
  end

  # GET /import_orders/new
  def new
    @import_order = Current.user.import_orders.build
  end

  # GET /import_orders/1/edit
  def edit
  end

  # POST /import_orders or /import_orders.json
  def create
    @import_order = Current.user.import_orders.build(import_order_params)

    respond_to do |format|
      if @import_order.save
        format.html { redirect_to url_for(@import_order), notice: "Import order was successfully created." }
        format.json { render :show, status: :created, location: @import_order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @import_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /import_orders/1 or /import_orders/1.json
  def update
    respond_to do |format|
      if @import_order.update(import_order_params)
        format.html { redirect_to import_order_url(@import_order), notice: "Import order was successfully updated." }
        format.json { render :show, status: :ok, location: @import_order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @import_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /import_orders/1 or /import_orders/1.json
  def destroy
    @import_order.destroy

    respond_to do |format|
      format.html { redirect_to import_orders_url, notice: "Import order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_import_order
    @import_order = Current.user.import_orders.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def import_order_params
    (import_order_params_by_uri || params)
      .require(:import_order)
      .permit(:import_orderable_type, {import_orderable_attributes: [:kind, :code, :uri]})
  end

  def import_order_params_by_uri
    uri_string = params.dig(:import_order, :uri)
    return if uri_string.blank?

    import_order_uri = ImportOrderUri.build(uri_string)

    ActionController::Parameters.new(
      {
        import_order: {
          import_orderable_type: import_order_uri.import_order_type,
          import_orderable_attributes: {
            kind: import_order_uri.kind_and_code.kind,
            code: import_order_uri.kind_and_code.code,
            uri: uri_string
          }
        }
      }
    )
  end

  def place_job
    return if @import_order.new_record?

    Rails.logger.info("controller: #{@import_order.inspect}")

    case @import_order.import_orderable_type
    when "MusicbrainzImportOrder"
      # TODO: choose the right Job depending on :kind
      Rails.logger.debug("ImportOrder#uri: #{@import_order.uri.inspect}")
      ImportMusicbrainzReleaseJob.perform_later(@import_order)
    else
      raise "can't enqueue job for #{@import_order}"
    end
  end
end
