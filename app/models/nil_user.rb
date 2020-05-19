class NilUser
  def email
    ''
  end

  def role
    'visitor'
  end

  def admin?
    false
  end

  def user?
    false
  end

  def subsidiary
    nil
  end

  def nil?
    true
  end

  def !
    true
  end
end