class RentalPresenter < SimpleDelegator
  attr_reader :user

  def initialize(rental, user = NilUser.new)
    @user = user
    super(rental)
  end

  def status_badge()
    css_class = STATUS_COLORS[status]
    h.content_tag :span, class: ["badge badge-#{css_class}"] do
      I18n.translate(status)
    end
  end

  def confirmation_form_partial
    return { plain: '' } unless ConfirmRentalPolicy.new(user, __getobj__).allowed?
    { partial: 'confirmation_form' }
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