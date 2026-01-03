class BackfillSaunaOpeningHoursFromLegacyTimes < ActiveRecord::Migration[7.1]
  def up
    Sauna.find_each do |sauna|
      (0..6).each do |dow|
        SaunaOpeningHour.find_or_create_by!(sauna_id: sauna.id, day_of_week: dow) do |h|
          if sauna.open_time.present? && sauna.close_time.present?
            h.opens_at  = sauna.open_time
            h.closes_at = sauna.close_time
            h.closed    = false
          else
            h.closed = true
          end
        end
      end
    end
  end

  def down
    SaunaOpeningHour.delete_all
  end
end
