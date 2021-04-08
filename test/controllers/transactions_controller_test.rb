# == Schema Information
#
# Table name: transactions
#
#  id                 :bigint           not null, primary key
#  donor_id           :bigint           not null
#  bluepay_id         :bigint
#  planning_center_id :bigint
#  payment_type       :string
#  amount             :decimal(, )
#  status             :string
#  message            :string
#  rebilling_id       :bigint
#  settlment_id       :bigint
#  bank_name          :string
#  address_1          :string
#  address_2          :string
#  city               :string
#  state              :string
#  zip_code           :string
#  phone              :string
#  email              :string
#  auth_code          :string
#  first_name         :string
#  last_name          :string
#  memo               :string
#  backend_id         :bigint
#  account_id         :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  processing_status  :integer          default("unprocessed"), not null
#  batch_id           :bigint           not null
#
# Indexes
#
#  index_transactions_on_batch_id    (batch_id)
#  index_transactions_on_bluepay_id  (bluepay_id)
#  index_transactions_on_donor_id    (donor_id)
#
# Foreign Keys
#
#  fk_rails_...  (batch_id => batches.id)
#  fk_rails_...  (donor_id => donors.id)
#
require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transaction = transactions(:one)
  end

  test "should get index" do
    get transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_transaction_url
    assert_response :success
  end

  test "should create transaction" do
    assert_difference('Transaction.count') do
      post transactions_url, params: { transaction: { account_id: @transaction.account_id, address_1: @transaction.address_1, address_2: @transaction.address_2, amount: @transaction.amount, auth_code: @transaction.auth_code, backend_id: @transaction.backend_id, bank_name: @transaction.bank_name, bluepay_id: @transaction.bluepay_id, city: @transaction.city, email: @transaction.email, first_name: @transaction.first_name, last_name: @transaction.last_name, memo: @transaction.memo, message: @transaction.message, payment_type: @transaction.payment_type, phone: @transaction.phone, rebilling_id: @transaction.rebilling_id, settlment_id: @transaction.settlment_id, state: @transaction.state, status: @transaction.status, zip_code: @transaction.zip_code } }
    end

    assert_redirected_to transaction_url(Transaction.last)
  end

  test "should show transaction" do
    get transaction_url(@transaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_transaction_url(@transaction)
    assert_response :success
  end

  test "should update transaction" do
    patch transaction_url(@transaction), params: { transaction: { account_id: @transaction.account_id, address_1: @transaction.address_1, address_2: @transaction.address_2, amount: @transaction.amount, auth_code: @transaction.auth_code, backend_id: @transaction.backend_id, bank_name: @transaction.bank_name, bluepay_id: @transaction.bluepay_id, city: @transaction.city, email: @transaction.email, first_name: @transaction.first_name, last_name: @transaction.last_name, memo: @transaction.memo, message: @transaction.message, payment_type: @transaction.payment_type, phone: @transaction.phone, rebilling_id: @transaction.rebilling_id, settlment_id: @transaction.settlment_id, state: @transaction.state, status: @transaction.status, zip_code: @transaction.zip_code } }
    assert_redirected_to transaction_url(@transaction)
  end

  test "should destroy transaction" do
    assert_difference('Transaction.count', -1) do
      delete transaction_url(@transaction)
    end

    assert_redirected_to transactions_url
  end
end
