class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.references :user, index: true

      t.string :title, null: false
      t.boolean :private, default: false

      t.timestamps
    end
  end
end
