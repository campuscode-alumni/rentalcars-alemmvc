class CarModelPresenter < SimpleDelegator
  include Rails.application.routes.url_helpers
  delegate :image_tag, :content_tag, :concat, to: :helpers

  def initialize(car_model)
    super(car_model)
  end

  def photo_tag
    return image_tag(photo_url, class: 'card-img-top')
  end

  def options_list
    return '' if car_options.strip.empty?
    content_tag('ul') do
      car_options.split(',') do |option|
        concat content_tag('li', option.strip)
      end
    end
  end

  private

  def helpers
    ApplicationController.helpers
  end

end
