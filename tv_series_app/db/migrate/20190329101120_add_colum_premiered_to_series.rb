class AddColumPremieredToSeries < ActiveRecord::Migration[5.2]
  def change
    add_column :series, :premiered, :string
  end
end
