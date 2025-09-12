class CreateUfValues < ActiveRecord::Migration[8.0]
  def change
    create_table :uf_values do |t|
      t.date :date
      t.decimal :value, precision: 10, scale: 2

      t.timestamps
    end
    add_index :uf_values, :date, unique: true
  end
end
