module ApplicationHelper
  # サウナタイプごとのキャラクター画像パス（app/assets/images 配下を想定）
  SAUNA_TYPE_CHARACTER_IMAGE = {
    "サウナモンク"         => "sauna_monk.png",
    "リセットマスター"     => "reset_master.png",
    "ヒートウォリアー"     => "heat_warrior.png",
    "ととのいアーティスト" => "totonoi_artist.png",
    "スチームメイト"       => "steam_mate.png",
    "ワークバランサー"     => "work_balancer.png",
    "ロウリュファイター"   => "loyly_fighter.png",
    "スチームクリエイター" => "steam_creator.png"
  }.freeze

  def sauna_character_image_path(sauna_type)
    return "default.png" if sauna_type.blank?

    # nameベースで紐づけ（DB変更なしで動く）
    SAUNA_TYPE_CHARACTER_IMAGE[sauna_type.name] || "default.png"
  end
end
