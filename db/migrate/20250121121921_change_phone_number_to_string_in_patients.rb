class ChangePhoneNumberToStringInPatients < ActiveRecord::Migration[7.1]
  def change
    change_column :patients, :phone_number, :string
  end
end
