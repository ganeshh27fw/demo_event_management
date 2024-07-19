class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :date
      t.string :city
      t.string :producer

      t.timestamps
    end
  end
end
