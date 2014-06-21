class BaseStrategy < Warden::Strategies::Base
  attr_reader :client, :client_id, :client_secret, :error_description, :valid_client

  def valid?
    raise RuntimeError, "Define valid? in subclass"
  end

  def authenticate!
    Rails.logger.debug "[warden] called from #{caller.first}"
    @client = client_from_strategy

    if self.client
      fail 'invalid_scope' and return if scope && client.respond_to?(:scope) && !client.scope?(scope)
      client_authenticated
    else
      fail 'invalid_client'
    end
  end

  def client_from_strategy
    raise RuntimeError, "Define client_from_strategy in subclass"
  end

  STATUSES = Hash.new(400).merge({
      'invalid_client' => 401,
      'invalid_token' => 401,
      'invalid_scope' => 403
  })
  def error_status
    STATUSES[message]
  end

  def model
    User
  end

  # 1. Override in subclass
  # 2. Set self.valid_client = authenticated? logic
  # 3. call super
  def client_authenticated
    if @valid_client
      success! self.client
    else
      self.error_description = 'Incorrect username or password'
      fail('invalid_client')
    end
  end

  # Used by strategies that have a password component (e.g. basic, form)
  def validate_client_secret
    unless self.client_secret
      self.error_description = 'Must provide password'
      fail('invalid_client')
    end
    @valid_client = self.client.valid_password?(self.client_secret)
  end

  # Should authentication from this strategy result in a permanent login?
  def store?
    true
  end

  def error_description
    @error_description || ''
  end

end
