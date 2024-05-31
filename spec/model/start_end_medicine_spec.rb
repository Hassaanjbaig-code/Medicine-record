require "rails_helper"

RSpec.describe StartEndMedicine, type: :model do
  before do
    @medicine = Medicine.create!(
      medicine_name: "Castine",
      use_for: "Use for the allgeri",
      medicine_mg: 10,
      image: "https://loremflickr.com/300/300"
    )
    @start_end = StartEndMedicine.create!(
      start_date: Date.parse("02 May 2024"),
      end_date: Date.parse("30 May 2024"),
      everyday: true,
      medicine_id: @medicine.id
    )
  end

  describe "Testing the start_end date medicine" do
    it "checks it is created" do
      expect(@start_end).to be_valid
    end
    it "check the start_date" do
      expect(@start_end.start_date).to eq(Date.parse("02 May 2024"))
    end
    it "check the end_date" do
      expect(@start_end.end_date).to eq(Date.parse("30 May 2024"))
    end
    it "check the everyday" do
      expect(@start_end.everyday).to eq(true)
    end
  end
end
