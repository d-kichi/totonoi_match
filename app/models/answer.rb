class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :sauna_type
end
