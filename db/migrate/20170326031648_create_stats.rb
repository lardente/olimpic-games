class CreateStats < ActiveRecord::Migration[5.0]
  def change
    create_table :stats do |t|
      t.references :competition, index: true, foreign_key: true
      t.references :athlete, index: true, foreign_key: true
      t.float :result
      t.string :metric

      t.timestamps
    end
  end
end
