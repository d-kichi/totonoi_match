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
    sauna_type_name(style, value)
  end

  private

  def calculate_scores
    @answers.each do |answer|
      @style_score[answer.style_type] += 1 if STYLE_KEYS.include?(answer.style_type)
      @value_score[answer.value_type] += 1 if VALUE_KEYS.include?(answer.value_type)
    end
  end

  def sauna_type_name(style, value)
    case [style, value]
    when ["solo", "relax"]       then "サウナモンク（Sauna Monk）"
    when ["solo", "reset"]       then "リセットマスター（Reset Master）"
    when ["solo", "challenge"]   then "ヒートウォリアー（Heat Warrior）"
    when ["solo", "creative"]    then "ととのいアーティスト（Totonoi Artist）"
    when ["social", "relax"]     then "スチームメイト（Steam Mate）"
    when ["social", "reset"]     then "ワークバランサー（Work Balancer）"
    when ["social", "challenge"] then "ロウリュファイター（Löyly Fighter）"
    when ["social", "creative"]  then "スチームクリエイター（Steam Creator）"
    else
      "診断不能（データ不足）"
    end
  end
end
