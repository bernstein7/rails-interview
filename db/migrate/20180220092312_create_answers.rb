class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.references :question, index: true
      t.references :user, index: true

      t.string :body, null: false, length: 1024

      t.timestamps
    end
  end
end
