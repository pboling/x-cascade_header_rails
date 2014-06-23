class HeaderTokenStrategy < BaseStrategy
  def valid?
    Rails.logger.debug "[warden] trying header_token strategy"

    token_value.present?
  end

  def client_from_strategy
    Rails.logger.debug "[warden] using header_token strategy"

    self.client = model.find_by(authentication_token: token_value)
  end

  def client_authenticated
    Rails.logger.debug "[warden] header_token authentication succeeded from #{request.ip}"
    self.valid_client = true
    super
  end

  def store?
    false
  end

  private

  def token_value
    if header && header =~ /^Token (.+)$/
      $~[1]
    end
  end

  def header
    request.env["HTTP_AUTHORIZATION"]
  end
end
