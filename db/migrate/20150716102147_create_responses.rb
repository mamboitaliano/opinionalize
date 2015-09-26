class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :text

      t.timestamps
      t.references :question, index: true
    end
  end
end
