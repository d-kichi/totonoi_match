class DiagnosisService
  STYLE_KEYS = %w[solo social].freeze
  VALUE_KEYS = %w[relax reset challenge creative].freeze

  def initialize(answers)
    @answers = answers
    @style_score = Hash.new(0)
    @value_score = Hash.new(0)
  end

  def call
    calculate_scores
    style = @style_score.max_by { |_, v| v }&.first
    value = @value_score.max_by { |_, v| v }&.first

    sauna_type_name = sauna_type_name(style, value)
    sauna_type = SaunaType.find_by(name: sauna_type_name)
    result = Result.find_by(sauna_type: sauna_type)

    return {
      type: sauna_type_name,
      headline: result&.headline || "診断結果が見つかりません",
      body: result&.body || "該当するタイプの詳細データがありません。",
      recommendation_note: result&.recommendation_note || ""
    }
  end

  private

  def calculate_scores
    @answers.each do |_, answer_id|
      answer = Answer.find(answer_id)
      @style_score[answer.style_type] += 1 if STYLE_KEYS.include?(answer.style_type)
      @value_score[answer.value_type] += 1 if VALUE_KEYS.include?(answer.value_type)
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
      "診断不能（データ不足）"
    end
  end
end
