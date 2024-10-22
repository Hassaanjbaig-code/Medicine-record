class RenameStartDateToStartTimeInStartEndMedicine < ActiveRecord::Migration[7.1]
  def change
    rename_column :start_end_medicines, :start_date, :start_time
    rename_column :start_end_medicines, :end_date, :end_time
  end
end
