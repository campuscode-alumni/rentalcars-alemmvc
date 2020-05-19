require 'rails_helper'


describe RentalCalculator do
  describe '.calculate' do
    subject { described_class.calculate(rental) }

    context 'rental has no category' do
      let(:rental) { build(:rental, category: nil) }
      it { is_expected.to eq 0 }
    end

    context 'rental has no start date' do
      let(:rental) { build(:rental, start_date: nil)}
      it { is_expected.to eq 0 }
    end

    context 'rental has no end date' do
      let(:rental) { build(:rental, start_date: nil)}
      it { is_expected.to eq 0 }
    end

    context 'start and end date are equal' do
      let(:fixed_date) { 1.day.from_now }
      let(:category) { create(:category, daily_rate: 25)}
      let(:rental) do 
        build(:rental, start_date: fixed_date, end_date: fixed_date,
                       category: category)
      end
      it { is_expected.to eq 25 }
    end

    context 'as expected' do
      let(:start_date) { 1.day.from_now }
      let(:end_date ) { 6.day.from_now }
      let(:category) { create(:category, daily_rate: 20)}
      let(:rental) do 
        build(:rental, start_date: start_date, end_date: end_date,
                       category: category)
      end
      it { is_expected.to eq 100 }
    end
  end
end