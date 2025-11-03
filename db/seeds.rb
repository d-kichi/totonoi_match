puts "🌿 Seeding start..."

# --- 初期化 ---
Answer.destroy_all
Question.destroy_all
SaunaType.destroy_all

# --- サウナタイプ（8タイプ） ---
sauna_types = SaunaType.create!([
  { name: 'サウナモンク', description: '静けさを極め、内なる自分と対話する求道者。' },
  { name: 'リセットマスター', description: '心身を整え、日常を再起動させる術師。' },
  { name: 'ヒートウォリアー', description: '熱と闘い、限界を突破する挑戦者。' },
  { name: 'ととのいアーティスト', description: '感性でサウナを味わう創造者。' },
  { name: 'スチームメイト', description: '仲間と笑いながらととのうコミュニケーター。' },
  { name: 'ワークバランサー', description: '仕事とサウナで心身の調律を極める均衡者。' },
  { name: 'ロウリュファイター', description: '熱波に魂を燃やし、仲間を鼓舞する戦士。' },
  { name: 'スチームクリエイター', description: 'サウナの魅力を発信し、文化を広める伝道者。' }
])

puts "✅ SaunaType created (#{sauna_types.count})"

# --- 質問・回答 ---
questions = [
  # --- ブロック1：過ごし方（solo / social） ---
  {
    content: 'サウナに行くときはどんな時間を求めてる？',
    answers: [
      { content: '静かに自分と向き合いたい', style_type: 'solo', score: 1 },
      { content: '仲間と話してストレス発散したい', style_type: 'social', score: 1 }
    ]
  },
  {
    content: 'サウナ室ではどう過ごしたい？',
    answers: [
      { content: '目を閉じて呼吸に集中', style_type: 'solo', score: 1 },
      { content: '会話や笑いがある空間が好き', style_type: 'social', score: 1 }
    ]
  },
  {
    content: 'サウナ後はどう過ごすのが理想？',
    answers: [
      { content: '外気浴でひとり時間', style_type: 'solo', score: 1 },
      { content: 'コーヒー牛乳飲みながら語らう', style_type: 'social', score: 1 }
    ]
  },

  # --- ブロック2：価値観（relax / reset / challenge / creative） ---
  {
    content: 'サウナで得たい一番の感覚は？',
    answers: [
      { content: '無になる', value_type: 'relax', score: 1 },
      { content: 'スッキリ再起動', value_type: 'reset', score: 1 },
      { content: '熱でぶっ飛ぶ', value_type: 'challenge', score: 1 },
      { content: '世界観に浸る', value_type: 'creative', score: 1 }
    ]
  },
  {
    content: 'サウナ選びで一番大事にしてるのは？',
    answers: [
      { content: '落ち着ける雰囲気', value_type: 'relax', score: 1 },
      { content: '温度や動線の最適さ', value_type: 'reset', score: 1 },
      { content: '高温・ロウリュ・水風呂の刺激', value_type: 'challenge', score: 1 },
      { content: '内装・照明・香りのセンス', value_type: 'creative', score: 1 }
    ]
  },
  {
    content: 'サウナに行く目的は？',
    answers: [
      { content: '癒やし・リラックス', value_type: 'relax', score: 1 },
      { content: '気持ちを切り替える', value_type: 'reset', score: 1 },
      { content: '自分を追い込みたい', value_type: 'challenge', score: 1 },
      { content: 'ととのう美学を楽しむ', value_type: 'creative', score: 1 }
    ]
  },
  {
    content: 'サウナ中に頭の中で考えてることは？',
    answers: [
      { content: '何も考えないようにしてる', value_type: 'relax', score: 1 },
      { content: '明日の段取りやアイデアを整理してる', value_type: 'reset', score: 1 },
      { content: 'あと何分耐えられるかな…と挑戦してる', value_type: 'challenge', score: 1 },
      { content: '空間の雰囲気や香り、音を味わってる', value_type: 'creative', score: 1 }
    ]
  },
  {
    content: 'サウナで一番テンション上がる瞬間は？',
    answers: [
      { content: '水風呂後の外気浴', value_type: 'relax', score: 1 },
      { content: '頭がクリアになってくる瞬間', value_type: 'reset', score: 1 },
      { content: 'アウフグースで汗が吹き出す瞬間', value_type: 'challenge', score: 1 },
      { content: 'ライト・音・香りが完璧にハマった瞬間', value_type: 'creative', score: 1 }
    ]
  },
  {
    content: 'サウナ後、どんな自分になってたい？',
    answers: [
      { content: '穏やかで満ち足りた気分', value_type: 'relax', score: 1 },
      { content: '思考も身体も整ってる感じ', value_type: 'reset', score: 1 },
      { content: '「やり切った！」という爽快感', value_type: 'challenge', score: 1 },
      { content: '新しい感覚や発見を得てる', value_type: 'creative', score: 1 }
    ]
  },
  {
    content: 'あなたにとって「ととのう」とは？',
    answers: [
      { content: '心と身体がやわらかくなること', value_type: 'relax', score: 1.5 }, # 少し重みを加える
      { content: '頭がクリアになり前向きになれること', value_type: 'reset', score: 1.5 },
      { content: '自分を超えた瞬間を感じること', value_type: 'challenge', score: 1.5 },
      { content: '感覚がひとつに溶け合う瞬間', value_type: 'creative', score: 1.5 }
    ]
  }
]

# --- 登録処理 ---
questions.each do |q|
  question = Question.create!(content: q[:content])
  q[:answers].each do |a|
    Answer.create!(
      content: a[:content],
      question_id: question.id,
      score: a[:score],
      style_type: a[:style_type],
      value_type: a[:value_type]
    )
  end
end

puts "✅ Questions & Answers created: #{Question.count} questions / #{Answer.count} answers"
puts "🌱 Done!"

# --- 以下を seeds.rb の末尾に追加してください ---

puts "✅ Creating Result data..."

results_data = [
  { sauna_type_name: "サウナモンク", headline: "内なる静寂の求道者", body: "一人時間を大切にし、瞑想的にサウナを味わうタイプ。静けさと内省を通して心を整えることを好みます。", recommendation_note: "落ち着いた照明・無音系サウナがおすすめ。" },
  { sauna_type_name: "リセットマスター", headline: "思考も体も再起動", body: "整理整頓が好きで、頭と体をリセットしたいときにサウナを活用するタイプ。効率的にととのうことを重視します。", recommendation_note: "温度安定・導線設計の良い施設を選ぶと◎" },
  { sauna_type_name: "ヒートウォリアー", headline: "限界突破の挑戦者", body: "熱に挑み、自分の限界を試すタイプ。アツさの中にこそ快感を見出す本格派サウナーです。", recommendation_note: "ロウリュ・アウフグースに積極的に参加しよう。" },
  { sauna_type_name: "ととのいアーティスト", headline: "感覚をデザインする人", body: "光・音・香りなどの空間演出に敏感で、五感でサウナを楽しむクリエイティブタイプです。", recommendation_note: "デザイン性の高い施設や香り付きサウナに惹かれる傾向。" },
  { sauna_type_name: "スチームメイト", headline: "笑い合ってととのう仲間派", body: "仲間と会話しながらのサウナ時間に癒されるタイプ。楽しさとつながりを重視します。", recommendation_note: "グループサウナ・貸切利用が向いている。" },
  { sauna_type_name: "ワークバランサー", headline: "整える集中の達人", body: "仕事帰りにサウナで頭をリセットし、翌日への切り替えを図るバランス型。整うことでパフォーマンスを上げます。", recommendation_note: "都市型サウナやコワーキング併設施設が◎" },
  { sauna_type_name: "ロウリュファイター", headline: "熱波を愛する戦士", body: "熱波と仲間をこよなく愛するアツいサウナー。全身でサウナ文化を楽しみ尽くすタイプです。", recommendation_note: "イベントロウリュ・熱波師のいる施設に行くべし。" },
  { sauna_type_name: "スチームクリエイター", headline: "発信するととのい伝道者", body: "SNSや言葉でサウナの魅力を広めるタイプ。感動を共有し、文化を発信するエネルギーに満ちています。", recommendation_note: "写真映えする施設・独自演出のある空間に惹かれる。" }
]

results_data.each do |data|
  sauna_type = SaunaType.find_by(name: data[:sauna_type_name])
  Result.create!(
    sauna_type: sauna_type,
    headline: data[:headline],
    body: data[:body],
    recommendation_note: data[:recommendation_note]
  )
end

puts "🌿 Results created successfully!"
