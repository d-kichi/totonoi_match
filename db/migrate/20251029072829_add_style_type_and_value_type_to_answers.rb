class AddStyleTypeAndValueTypeToAnswers < ActiveRecord::Migration[7.1]
  def change
    add_column :answers, :style_type, :string
    add_column :answers, :value_type, :string
  end
end
