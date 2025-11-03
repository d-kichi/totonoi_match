ActiveAdmin.register Sauna do
  permit_params :name, :location, :latitude, :longitude, :temperature, :water_temp,
                :has_outdoor_bath, :open_time, :close_time, :description, :sauna_type_id

  index do
    selectable_column
    id_column
    column :name
    column :location
    column :temperature
    column :water_temp
    column :has_outdoor_bath
    column :open_time
    column :close_time
    actions
  end

  form do |f|
    f.inputs "サウナ情報" do
      f.input :name
      f.input :location
      f.input :latitude
      f.input :longitude
      f.input :temperature
      f.input :water_temp
      f.input :has_outdoor_bath
      f.input :open_time
      f.input :close_time
      f.input :description
      f.input :sauna_type
    end
    f.actions
  end
end
