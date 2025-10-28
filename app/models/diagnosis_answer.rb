class DiagnosisAnswer < ApplicationRecord
  belongs_to :diagnosis
  belongs_to :question
  belongs_to :answer
end
