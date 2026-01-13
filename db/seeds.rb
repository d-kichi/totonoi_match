puts "🌿 Seeding start..."

# --- 初期化 ---
# seeds は「初期投入」用途。production で destroy_all すると運用データが消えるため禁止。
if Rails.env.development? || Rails.env.test?
  Answer.destroy_all
  Question.destroy_all
  Result.destroy_all
  SaunaOpeningHour.destroy_all
  Sauna.destroy_all
  SaunaType.destroy_all
else
  puts "⚠️ #{Rails.env}: destroy_all is skipped (safe seed mode)"
end

# --- サウナタイプ（8タイプ） ---
sauna_types_data = [
  { name: 'サウナモンク', description: '静けさを極め、内なる自分と対話する求道者。' },
  { name: 'リセットマスター', description: '心身を整え、日常を再起動させる術師。' },
  { name: 'ヒートウォリアー', description: '熱と闘い、限界を突破する挑戦者。' },
  { name: 'ととのいアーティスト', description: '感性でサウナを味わう創造者。' },
  { name: 'スチームメイト', description: '仲間と笑いながらととのうコミュニケーター。' },
  { name: 'ワークバランサー', description: '仕事とサウナで心身の調律を極める均衡者。' },
  { name: 'ロウリュファイター', description: '熱波に魂を燃やし、仲間を鼓舞する戦士。' },
  { name: 'スチームクリエイター', description: 'サウナの魅力を発信し、文化を広める伝道者。' }
]

sauna_types = sauna_types_data.map do |attrs|
  st = SaunaType.find_or_initialize_by(name: attrs[:name])

  if Rails.env.development? || Rails.env.test?
    # 開発/テストは seed を正として上書き
    st.description = attrs[:description]
    st.save!
  else
    # 本番は「無ければ作る」＋「空欄だけ補完」（管理画面の編集を壊さない）
    if st.new_record?
      st.description = attrs[:description]
      st.save!
    else
      if st.description.blank?
        st.description = attrs[:description]
        st.save!
      else
        puts "↪︎ production: SaunaType '#{st.name}' exists, skip update"
      end
    end
  end

  st
end

puts "✅ SaunaType ensured (#{sauna_types.count})"

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
  question = Question.find_or_create_by!(content: q[:content])

  q[:answers].each do |a|
    answer = Answer.find_or_initialize_by(question: question, content: a[:content])
    answer.score = a[:score]
    answer.style_type = a[:style_type]
    answer.value_type = a[:value_type]
    answer.save!
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
  next unless sauna_type

  result = Result.find_or_initialize_by(sauna_type: sauna_type)

  if Rails.env.development? || Rails.env.test?
    # 開発/テストは seed を正として上書き
    result.headline = data[:headline]
    result.body = data[:body]
    result.recommendation_note = data[:recommendation_note]
    result.save!
  else
    # 本番は「無ければ作る」＋「空欄だけ補完」（管理画面の編集を壊さない）
    if result.new_record?
      result.headline = data[:headline]
      result.body = data[:body]
      result.recommendation_note = data[:recommendation_note]
      result.save!
    else
      changed = false

      if result.headline.blank?
        result.headline = data[:headline]
        changed = true
      end
      if result.body.blank?
        result.body = data[:body]
        changed = true
      end
      if result.recommendation_note.blank?
        result.recommendation_note = data[:recommendation_note]
        changed = true
      end

      if changed
        result.save!
      else
        puts "↪︎ production: Result for '#{sauna_type.name}' exists, skip update"
      end
    end
  end
end

puts "🔥 Creating Sauna data..."

saunas_data = [
  { name: "サウナ東京", address: "東京都港区赤坂", temperature: 90, water_temp: 16, has_outdoor_bath: true,
    opens_at: "06:00", closes_at: "23:00", description: "静けさと照明のバランスが極上。瞑想的な空間で内省できる。",
    sauna_type_name: "サウナモンク", website_url: nil },

  { name: "タイムズ スパ・レスタ", address: "東京都豊島区東池袋", temperature: 92, water_temp: 15, has_outdoor_bath: true,
    opens_at: "11:30", closes_at: "08:30", description: "都会のリセット空間。清潔で動線が整っており、整いやすい環境。",
    sauna_type_name: "リセットマスター", website_url: nil },

  { name: "渋谷SAUNAS", address: "東京都渋谷区桜丘町", temperature: 100, water_temp: 10, has_outdoor_bath: false,
    opens_at: "07:00", closes_at: "23:00", description: "多様なサウナ室で限界突破。熱と冷のギャップを楽しむ挑戦型。",
    sauna_type_name: "ヒートウォリアー", website_url: nil },

  { name: "黄金湯", address: "東京都墨田区太平", temperature: 94, water_temp: 14, has_outdoor_bath: true,
    opens_at: "06:00", closes_at: "24:30", description: "アート・音楽・銭湯が融合。感性でととのう非日常空間。",
    sauna_type_name: "ととのいアーティスト", website_url: nil },

  { name: "SAUNA & co", address: "東京都台東区蔵前", temperature: 88, water_temp: 17, has_outdoor_bath: false,
    opens_at: "10:00", closes_at: "23:00", description: "ナチュラルデザイン×会話空間。共感と癒しのソーシャルサウナ。",
    sauna_type_name: "スチームメイト", website_url: nil },

  { name: "サウナ&カプセル北欧", address: "東京都台東区上野", temperature: 98, water_temp: 13, has_outdoor_bath: false,
    opens_at: "24時間営業", closes_at: nil, description: "大衆サウナの王道。仲間と“整う”体験を共有できる。",
    sauna_type_name: "ワークバランサー", website_url: nil },

  { name: "HUBHUB御徒町", address: "東京都台東区上野", temperature: 102, water_temp: 11, has_outdoor_bath: false,
    opens_at: "10:00", closes_at: "24:00", description: "貸切×高温×盛り上がる空気。仲間で挑戦するグループ向け。",
    sauna_type_name: "ロウリュファイター", website_url: nil },

  { name: "KUDOCHI sauna", address: "東京都中央区銀座", temperature: 90, water_temp: 15, has_outdoor_bath: false,
    opens_at: "09:00", closes_at: "23:00", description: "デザイン美×創造性。仲間と感性を共有する空間。",
    sauna_type_name: "スチームクリエイター", website_url: nil }
]

# Seeds内の営業時間文字列を time型に寄せる（B-2の曜日別テーブルに保存）
normalize_time_str = lambda do |s|
  return nil if s.nil?
  str = s.to_s.strip
  return nil if str.empty?

  # "24:00" / "24:30" を time型で扱える形へ
  return "00:00" if str == "24:00"
  return "00:30" if str == "24:30"

  str
end

saunas_data.each do |data|
  sauna_type = SaunaType.find_by(name: data[:sauna_type_name])

  sauna = Sauna.find_or_initialize_by(name: data[:name])

  if Rails.env.development? || Rails.env.test?
    # 開発/テストは seed を正として上書き
    sauna.address = data[:address]
    sauna.temperature = data[:temperature]
    sauna.water_temp = data[:water_temp]
    sauna.has_outdoor_bath = data[:has_outdoor_bath]
    sauna.description = data[:description]
    sauna.sauna_type = sauna_type
    sauna.website_url = data[:website_url]
    sauna.save!
  else
    # 本番は「無ければ作る」＋「空欄だけ補完」（管理画面の編集を壊さない）
    if sauna.new_record?
      sauna.address = data[:address]
      sauna.temperature = data[:temperature]
      sauna.water_temp = data[:water_temp]
      sauna.has_outdoor_bath = data[:has_outdoor_bath]
      sauna.description = data[:description]
      sauna.sauna_type = sauna_type
      sauna.website_url = data[:website_url]
      sauna.save!
    else
      changed = false

      if sauna.address.blank?
        sauna.address = data[:address]
        changed = true
      end
      if sauna.temperature.blank?
        sauna.temperature = data[:temperature]
        changed = true
      end
      if sauna.water_temp.blank?
        sauna.water_temp = data[:water_temp]
        changed = true
      end
      if sauna.has_outdoor_bath.nil?
        sauna.has_outdoor_bath = data[:has_outdoor_bath]
        changed = true
      end
      if sauna.description.blank?
        sauna.description = data[:description]
        changed = true
      end
      if sauna.sauna_type.nil?
        sauna.sauna_type = sauna_type
        changed = true
      end
      if sauna.website_url.blank?
        sauna.website_url = data[:website_url]
        changed = true
      end

      if changed
        sauna.save!
      else
        puts "↪︎ production: Sauna '#{sauna.name}' exists, skip update"
      end
    end
  end

  # 24時間営業などの例外を吸収
  opens_raw  = data[:opens_at]
  closes_raw = data[:closes_at]

  if opens_raw.to_s.include?("24時間")
    opens_at  = "00:00"
    closes_at = "23:59"
  else
    opens_at  = normalize_time_str.call(opens_raw)
    closes_at = normalize_time_str.call(closes_raw)
  end

  # 曜日7件
  (0..6).each do |dow|
    oh = SaunaOpeningHour.find_or_initialize_by(sauna: sauna, day_of_week: dow)

    if Rails.env.development? || Rails.env.test?
      # 開発/テストは seed を正として上書き
      oh.closed = false
      oh.opens_at = opens_at
      oh.closes_at = closes_at
      oh.save!
    else
      # 本番は「無ければ作る」だけ（管理画面での編集を壊さない）
      if oh.new_record?
        oh.closed = false
        oh.opens_at = opens_at
        oh.closes_at = closes_at
        oh.save!
      end
    end
  end
end

puts "✅ Saunas created successfully!"

puts "🌿 Results created successfully!"
# 管理画面ログインは User で統一（admin: true）
admin_email    = ENV.fetch("ADMIN_EMAIL", "admin@example.com")
admin_password = ENV.fetch("ADMIN_PASSWORD", "password123") # 本番は必ず変える

admin = User.find_or_initialize_by(email: admin_email)

# username が空の場合のみ、被らない username を採番する
if admin.username.blank?
  base = "admin"
  candidate = base
  suffix = 1
  while User.where.not(id: admin.id).exists?(username: candidate)
    suffix += 1
    candidate = "#{base}#{suffix}"
  end
  admin.username = candidate
end

# 初回作成時のみパスワード投入（既存ユーザーのパスワードは変更しない）
admin.password = admin_password if admin.new_record? || admin.encrypted_password.blank?

# admin カラムがある場合のみ true にする（環境差で落ちない）
admin.admin = true if admin.respond_to?(:admin)

admin.save!
puts "✅ Admin user ensured: #{admin.email} (username=#{admin.username})"
