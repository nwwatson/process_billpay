class TransactionsController < ApplicationController
  before_action :authenticate_user!, :filter_param
  before_action :set_transaction, only: %i[ show edit update destroy process ]

  layout 'administration'

  # GET /transactions or /transactions.json
  def index
    @transactions = current_view Transaction.all
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions/1/process
  def submission
    Rails.logger.info "Processing transaction #{params[:id]}"
    redirect_to transactions_path, success: "Processing transaction #{params[:id]}"
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: "Transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:bluepay_id, :payment_type, :amount, :status, :message, :rebilling_id, :settlment_id, :bank_name, :address_1, :address_2, :city, :state, :zip_code, :phone, :email, :auth_code, :first_name, :last_name, :memo, :backend_id, :account_id)
    end

    def filter_param
      if params[:filter]
        session[:transaction_filter] = params[:filter] || nil
      end
    end

    def current_view(scope)
      case session[:transaction_filter]
      when "unprocessed"
        scope.unprocessed
      when "unprocessable"
        scope.unprocessable
      when "processed"
        scope.processed
      when "all"
        scope.all
      else
        scope.unprocessed
      end
    end
end
