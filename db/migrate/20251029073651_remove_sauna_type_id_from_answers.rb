class RemoveSaunaTypeIdFromAnswers < ActiveRecord::Migration[7.1]
  def change
    remove_reference :answers, :sauna_type, foreign_key: true
  end
end
