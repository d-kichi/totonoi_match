class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.text :content
      t.integer :score
      t.references :question, null: false, foreign_key: true
      t.references :sauna_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
