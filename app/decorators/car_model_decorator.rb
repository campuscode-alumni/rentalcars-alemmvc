class CarModelDecorator < Draper::Decorator
  delegate_all
  include Rails.application.routes.url_helpers

  def car_options
    super.split(', ')
  end

  def photo_url
    return rails_blob_url(photo) if photo.attached?

    'https://place-hold.it/100x100'
  end
end
