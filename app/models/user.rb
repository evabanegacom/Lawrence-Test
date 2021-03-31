class User < ApplicationRecord
  has_secure_password
  def as_json(options = {})
    super(options.merge({ except: %i[password_digest created_at updated_at] }))
  end
end
