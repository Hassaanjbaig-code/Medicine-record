class AddColumnIssuingAuthorityToSpecilization < ActiveRecord::Migration[7.1]
  def change
    add_column :specializations, :issuing_authority, :string
    add_column :specializations, :issue_date, :date
    add_column :specializations, :expire_date, :date
    rename_column :specializations, :lincense, :license
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
