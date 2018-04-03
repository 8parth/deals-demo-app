class DropTablePipelines < ActiveRecord::Migration[5.1]
  def change
    drop_table :pipelines
  end
end
