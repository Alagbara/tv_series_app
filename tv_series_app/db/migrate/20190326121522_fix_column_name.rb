class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :series, :run_time, :runtime
  end
end
