class CreateDiagnosisAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :diagnosis_answers do |t|
      t.references :result, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
