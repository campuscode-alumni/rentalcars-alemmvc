class RentalPresenter < SimpleDelegator
  delegate :content_tag, :link_to, to: :helper
  attr_reader :user

  def initialize(rental, user = nil)
    super(rental)
    @user = user
  end

  def status_badge()
    status_map = { "finalized" => 'primary', "scheduled" => 'success'}
    content_tag(:span, class: "badge badge-#{status_map[status()]}") do
      I18n.t(status).capitalize
    end
  end

  def next_action_link
    return '' unless user
    return '' unless user.admin? || subsidiary == user.subsidiary

    if scheduled?
      return link_to('Iniciar Locação', routes.review_rental_path(self))
    elsif ongoing?
      return link_to('Finalizar Locação', routes.finish_rental_path(self))
    end
  end

  private
  def helper
    ApplicationController.helpers
  end

  def routes
    Rails.application.routes.url_helpers
  end
end
