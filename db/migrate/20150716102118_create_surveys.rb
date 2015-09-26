class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :title

      t.timestamps
      t.references :user, index: true
    end
  end
end
