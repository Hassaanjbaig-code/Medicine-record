require 'rails_helper'

RSpec.describe Medicine, type: :model do
  describe "Medicine check" do
    before do
      @medicine = Medicine.create!(
        medicine_name: "Castine",
        use_for: "Use for the allgeri",
        medicine_mg: 10,
        image: "https://loremflickr.com/300/300"
      )
    end
    it "should check that the Medicine is created" do
      expect(@medicine).to be_valid
    end
    it "Name of medicine" do
      expect(@medicine.medicine_name).to eq("Castine")
    end
    it "use for of medicine" do
      expect(@medicine.use_for).to eq("Use for the allgeri")
    end
    it "medicine mg for medicine" do
      expect(@medicine.medicine_mg).to eq(10)
    end
  end

end
