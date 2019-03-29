class FixAnotherColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :series, :type, :series_type
  end
end
