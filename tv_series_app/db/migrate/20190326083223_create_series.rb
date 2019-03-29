  class CreateSeries < ActiveRecord::Migration[5.2]
  def change
    create_table :series do |t|
      t.string :name
      t.string :type
      t.string :language
      t.integer :run_time

      t.timestamps
      
    end
  end
end
