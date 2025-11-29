ActiveAdmin.register Inquiry do
  # 一覧・詳細・削除だけ使えれば十分
  actions :index, :show, :destroy

  # strong parameters（将来 admin から新規作成したくなった時用）
  permit_params :name, :email, :message

  # 一覧画面
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :message do |inquiry|
      truncate(inquiry.message, length: 50)
    end
    column :created_at
    actions
  end

  # フィルタ
  filter :name
  filter :email
  filter :created_at

  # 詳細画面
  show do
    attributes_table do
      row :id
      row :name
      row :email
      row :message do |inquiry|
        simple_format(inquiry.message)
      end
      row :created_at
    end

    active_admin_comments
  end
end
