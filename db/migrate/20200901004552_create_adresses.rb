class CreateAdresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.integer :number
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :zip
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
