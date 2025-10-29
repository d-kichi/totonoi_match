class ChangeSaunaTypeIdNullableInAnswers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :answers, :sauna_type_id, true
  end
end
