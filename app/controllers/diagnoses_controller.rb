class DiagnosesController < ApplicationController
  before_action :set_questions

  def new
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
    # 診断ロジック呼び出し
    service = DiagnosisService.new(session[:answers])
    @result = service.call
  end

  private

  def set_questions
    @questions = Question.order(:id)
  end
end
