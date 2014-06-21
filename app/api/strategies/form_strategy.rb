class FormStrategy < BaseStrategy
  attr_reader :client, :client_id, :client_secret, :error_description

  def valid?
    Rails.logger.debug "[warden] trying form strategy"

    params['username'].present? && params['password']
  end

  def client_from_strategy
    Rails.logger.debug "[warden] using form strategy"
    @client_id, @client_secret = params['username'], params['password']
    return nil unless self.client_id && self.client_secret
    model.find_for_database_authentication(:email => @client_id)
  end

  def client_authenticated
    Rails.logger.debug "[warden] authenticating form strategy"
    validate_client_secret
    super
  end

end
