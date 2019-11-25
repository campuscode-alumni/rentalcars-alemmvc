class CorporateClient < Client
  validates :email, presence: true
  validates :trade_name, presence: true
  validates :cnpj, presence: true

  def name
    self.trade_name
  end

  def cpf
    self.cnpj
  end

  def client_description
    "#{self.name} | CNPJ: #{self.cpf} | #{self.email}"
  end
end
