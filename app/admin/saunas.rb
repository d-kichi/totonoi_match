ActiveAdmin.register Sauna do
  permit_params :name, :address, :latitude, :longitude, :temperature, :water_temp,
                :has_outdoor_bath, :description, :sauna_type_id, :website_url,
                sauna_opening_hours_attributes: %i[id day_of_week opens_at closes_at closed _destroy]

  # Ransack 4.x では関連(filter)が未許可だと `reviews_id_eq` 等で 500 になるため、
  # 自動生成される reviews のフィルタを無効化する。
  remove_filter :reviews
  remove_filter :favorites
  remove_filter :favorited_by_users

  index do
    selectable_column
    id_column
    column :name
    column :address
    column :temperature
    column :water_temp
    column :has_outdoor_bath
    column :website_url
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :address
      row :website_url
      row :latitude
      row :longitude
      row :temperature
      row :water_temp
      row :has_outdoor_bath
      row :sauna_type
      row :description
      row :created_at
      row :updated_at
    end

    panel "営業時間（曜日別）" do
      table_for resource.sauna_opening_hours.order(:day_of_week) do
        column("曜日") do |h|
          %w[日 月 火 水 木 金 土][h.day_of_week.to_i]
        end
        column("定休日") { |h| h.closed ? "休" : "" }
        column("開始") { |h| h.opens_at&.strftime("%H:%M") }
        column("終了") { |h| h.closes_at&.strftime("%H:%M") }
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs "サウナ情報" do
      f.input :name
      f.input :address
      f.input :website_url
      f.input :latitude
      f.input :longitude
      f.input :temperature
      f.input :water_temp
      f.input :has_outdoor_bath
      f.input :description
      f.input :sauna_type
    end

    f.inputs "営業時間（曜日別）" do
      day_options = [["日", 0], ["月", 1], ["火", 2], ["水", 3], ["木", 4], ["金", 5], ["土", 6]]

      f.has_many :sauna_opening_hours, allow_destroy: true, new_record: "追加" do |h|
        h.input :day_of_week, as: :select, collection: day_options, include_blank: false
        h.input :closed
        h.input :opens_at, as: :time_picker
        h.input :closes_at, as: :time_picker
      end
    end

    f.actions
  end
end
