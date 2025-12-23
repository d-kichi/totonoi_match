ActiveAdmin.register User do
  permit_params :email, :username, :admin

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :admin
    column :created_at
    actions
  end

  filter :email
  filter :username
  filter :admin
  filter :created_at

  form do |f|
    f.inputs "ユーザー情報" do
      f.input :email
      f.input :username
      f.input :admin
    end
    f.actions
  end
end
