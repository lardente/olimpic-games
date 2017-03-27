class CreateCompetitions < ActiveRecord::Migration[5.0]
  def change
    create_table :competitions do |t|
      t.string :name
      t.string :type
      t.boolean :active

      t.timestamps
    end
  end
end
