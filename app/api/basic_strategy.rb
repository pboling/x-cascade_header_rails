class BasicStrategy < BaseStrategy

  def valid?
    Rails.logger.debug "[warden] trying basic strategy"

    (env.keys & Rack::Auth::AbstractRequest::AUTHORIZATION_KEYS).any?
  end

  def client_from_strategy
    Rails.logger.debug "[warden] using basic strategy"
    @client_id, @client_secret = *Rack::Auth::Basic::Request.new(env).credentials
    model.find_for_database_authentication(:email => @client_id)
  end

  def client_authenticated
    Rails.logger.debug "[warden] authenticating basic strategy"
    validate_client_secret
    super
  end

end
