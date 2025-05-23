class RemoveSpecializationToDoctorRigesters < ActiveRecord::Migration[7.1]
  def change
    remove_column :doctor_registers, :specialization
  end
end
