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
class Batch < ApplicationRecord
  # The updating state is temporary and describe's a Batch that is
  # currently being changed in some way (e.g. moving from in_progress
  # to committed). Certain changes to Batches in this state
  # (or their Donations) will be restricted until the Batch has
  # finished updating.
  enum status: { fake: 0, in_progress: 1, updating: 2, commited: 3 }

  has_many :transactions, dependent: :destroy

  before_destroy :delete_planning_center_batch

  private

  def delete_planning_center_batch
    PlanningCenter::DeleteBatchCommand.call(self)
  end
end
