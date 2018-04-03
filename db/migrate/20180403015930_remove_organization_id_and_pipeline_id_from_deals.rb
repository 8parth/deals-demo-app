class RemoveOrganizationIdAndPipelineIdFromDeals < ActiveRecord::Migration[5.1]
  def change
    remove_reference :deals, :organization, foreign_key: true
    remove_reference :deals, :pipeline, foreign_key: true
  end
end
