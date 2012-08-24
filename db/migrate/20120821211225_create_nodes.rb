class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.integer :provider_id
      t.string :input_type
      t.string :output_type

      t.timestamps
    end
  end
end
