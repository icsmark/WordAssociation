class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word
      t.integer :pos
      t.string :neighbor
      t.string :string
      t.integer :score
      t.references :book, index: true

      t.timestamps
    end
  end
end
