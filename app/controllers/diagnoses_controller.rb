class DiagnosesController < ApplicationController
  before_action :set_questions

  def new
    session[:answers] = {}
    redirect_to question_diagnosis_path(id: 1, step: 1)
  end

  def question
    @step = params[:step].to_i
    @questions = Question.order(:id)
    @question = @questions[@step - 1]
  end

  def answer
    step = params[:step].to_i
    next_step = step + 1
    session[:answers] ||= {}
    session[:answers][step] = params[:answer]

    total_questions = Question.count
    Rails.logger.info "STEP: #{step}, NEXT: #{next_step}, TOTAL: #{total_questions}"

    if next_step > total_questions
      redirect_to result_diagnoses_path
    else
      redirect_to question_diagnosis_path(id: 1, step: next_step)
    end
  end

  def result
    service = DiagnosisService.new(session[:answers])
    result_data = service.call  # ここで返ってくるのは { sauna_type_id: 3 } のようなデータと想定
  
    # sauna_type_idをキーにResultを取得
    @result = Result.find_by(sauna_type_id: result_data[:sauna_type_id])
  end

  def reset
    session[:answers] = {}  # 診断回答データをリセット
    redirect_to root_path, notice: '診断データをリセットしました'
  end
  
  private

  def set_questions
    @questions = Question.order(:id)
  end
end
