class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text			    # TODO: define acceptable chars
      t.string :explanation		# TODO: define acceptable chars
      t.boolean :required     
      t.integer :resp_type 		# TODO: define acceptable response types
      t.string :resp_choices	# TODO: define acceptable response choices

      t.timestamps
      t.references :survey, index: true
    end
  end
end
