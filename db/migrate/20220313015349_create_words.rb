class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.references :user, foreign_key: true
      t.text :english
      t.text :japanese

      t.timestamps
    end
  end
end
