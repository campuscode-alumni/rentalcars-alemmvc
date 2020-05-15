require 'rails_helper'

describe CarModelPresenter do

  describe '#photo_tag' do
    it 'should render default photo if not photo' do
      car_model = build(:car_model, photo: nil).decorate

      result = CarModelPresenter.new(car_model).photo_tag

      expect(result).to eq "<img class=\"card-img-top\" src=\"#{car_model.photo_url}\" />"
    end

    it 'should render photo' do
      car_model = create(:car_model).decorate
      photo_path = Rails.root.join('spec/support/car.jpg')
      car_model.photo.attach(io: File.open(photo_path), filename: 'car.jpg')
      car_model.save

      result = CarModelPresenter.new(car_model).photo_tag
      puts result
      expect(result).to eq "<img class=\"card-img-top\" src=\"#{car_model.photo_url}\" />"
    end
  end

  describe '#options_list' do
    it 'should render as an <ul>' do
      car_model = build(:car_model, car_options: 'ar condicionado, ABS')

      result = CarModelPresenter.new(car_model).options_list

      expect(result).to eq '<ul><li>ar condicionado</li><li>ABS</li></ul>'
    end

    it 'should render nothing if nil' do
      car_model = build(:car_model, car_options: ' ')

      result = CarModelPresenter.new(car_model).options_list

      expect(result).to eq ''
    end
  end

end