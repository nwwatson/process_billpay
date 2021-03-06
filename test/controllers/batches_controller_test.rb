# == Schema Information
#
# Table name: batches
#
#  id                 :bigint           not null, primary key
#  planning_center_id :bigint           not null
#  description        :string
#  committed_at       :datetime
#  total_cents        :integer
#  total_currency     :string
#  status             :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_batches_on_planning_center_id  (planning_center_id)
#
require "test_helper"

class BatchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @batch = batches(:one)
  end

  test "should get index" do
    get batches_url
    assert_response :success
  end

  test "should get new" do
    get new_batch_url
    assert_response :success
  end

  test "should create batch" do
    assert_difference('Batch.count') do
      post batches_url, params: { batch: { committed_at: @batch.committed_at, description: @batch.description, status: @batch.status, total_cents: @batch.total_cents, total_currency: @batch.total_currency } }
    end

    assert_redirected_to batch_url(Batch.last)
  end

  test "should show batch" do
    get batch_url(@batch)
    assert_response :success
  end

  test "should get edit" do
    get edit_batch_url(@batch)
    assert_response :success
  end

  test "should update batch" do
    patch batch_url(@batch), params: { batch: { committed_at: @batch.committed_at, description: @batch.description, status: @batch.status, total_cents: @batch.total_cents, total_currency: @batch.total_currency } }
    assert_redirected_to batch_url(@batch)
  end

  test "should destroy batch" do
    assert_difference('Batch.count', -1) do
      delete batch_url(@batch)
    end

    assert_redirected_to batches_url
  end
end
