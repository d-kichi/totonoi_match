class DiagnosesController < ApplicationController
  def new
    @questions = Question.includes(:answers).order(:id)
  end

  def create
    # params[:answer_ids] にユーザーの回答（Answer.id）が入ってる前提
    answers = Answer.where(id: params[:answer_ids].values)
    @result_type = DiagnosisService.new(answers).call
    redirect_to result_diagnoses_path(result_type: @result_type)
  end

  def result
    @result_type = params[:result_type]
    @sauna_type = SaunaType.find_by(name: @result_type)
  end
end
