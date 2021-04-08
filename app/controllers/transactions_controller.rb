class TransactionsController < ApplicationController
  before_action :authenticate_user!, :filter_param
  before_action :set_transaction, only: %i[ edit update ]

  layout 'administration'

  # GET /transactions/1/edit
  def edit
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to batch_path(@batch), notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.includes(:batch).find(params[:id])
      @batch = @transaction.batch
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(
        donor_attributes: [:id, :planning_center_person_id]
      )
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
