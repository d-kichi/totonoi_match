class DiagnosisService
  STYLE_KEYS = %w[solo social].freeze
  VALUE_KEYS = %w[relax reset challenge creative].freeze

  class DataInsufficientError < StandardError; end

  def initialize(answers)
    @answers = answers
    @style_score = Hash.new(0)
    @value_score = Hash.new(0)
  end

  def call
    calculate_scores

    # 最も多かったスタイルと価値観を抽出
    style = @style_score.max_by { |_, v| v }&.first
    value = @value_score.max_by { |_, v| v }&.first

    sauna_type_name = sauna_type_name(style, value)
    raise DataInsufficientError, "診断データが不足しているため判定できません" if sauna_type_name.blank?

    sauna_type = SaunaType.find_by(name: sauna_type_name)
    raise DataInsufficientError, "サウナタイプ（#{sauna_type_name}）が見つかりません" if sauna_type.blank?

    result = Result.find_by(sauna_type: sauna_type)
    raise DataInsufficientError, "診断結果（#{sauna_type_name}）が見つかりません" if result.blank?

    result
  end

  private

  def calculate_scores
    return if @answers.nil?

    @answers.each do |question_id, answer_id|
      answer = Answer.find(answer_id)

      # style_type か value_type のどちらかが存在すれば、それぞれスコア加算
      @style_score[answer.style_type] += answer.score if STYLE_KEYS.include?(answer.style_type)
      @value_score[answer.value_type] += answer.score if VALUE_KEYS.include?(answer.value_type)
    end
  end

  def sauna_type_name(style, value)
    case [style, value]
    when ["solo", "relax"]       then "サウナモンク"
    when ["solo", "reset"]       then "リセットマスター"
    when ["solo", "challenge"]   then "ヒートウォリアー"
    when ["solo", "creative"]    then "ととのいアーティスト"
    when ["social", "relax"]     then "スチームメイト"
    when ["social", "reset"]     then "ワークバランサー"
    when ["social", "challenge"] then "ロウリュファイター"
    when ["social", "creative"]  then "スチームクリエイター"
    else
      nil
    end
  end
end
