class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :title
      t.string :description
      t.boolean :is_public
      t.string :unique_url

      t.timestamps
      t.references :user, index: true
    end
  end
end
