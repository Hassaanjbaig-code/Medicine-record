class ChangeClinicsFieldsType < ActiveRecord::Migration[7.1]
  def change
    change_column :clinics, :contact_number, :string
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
