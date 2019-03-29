class AddColumOfficialsiteToSeries < ActiveRecord::Migration[5.2]
  def change
    add_column :series, :officialsite, :string
  end
end
