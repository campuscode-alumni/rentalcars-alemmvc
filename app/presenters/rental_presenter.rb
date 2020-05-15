class RentalPresenter < SimpleDelegator
  def initialize(rental)
    super(rental)
  end

  def status_badge()
    css_class = STATUS_COLORS[status]
    h.content_tag :span, class: ["badge badge-#{css_class}"] do
      I18n.translate(status)
    end
  end

  private

  STATUS_COLORS = { 'scheduled' => 'info',
                    'in_review' => 'light',
                    'ongoing' => 'success', 
                    'finalized' => 'primary' }

  def h
    ApplicationController.helpers
  end

end