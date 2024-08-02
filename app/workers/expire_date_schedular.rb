require "sidekiq-scheduler"


class ExpireDateSchedular
  include Sidekiq::Worker

  def perform
    p "ExpireDate is Working"

    date = StartEndMedicine.where("end_date < ?", Date.today)
    if date.empty?
      p "Date is not empty"
    else
      date.each do |medicine_date|
        medicine_found = Medicine.find_by_id(medicine_date.medicine_id)
        medicine_found.update(completed: true)
      end
    end
  end
end
