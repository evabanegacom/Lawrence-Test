class User < ApplicationRecord
  has_secure_password
  has_many :transactions, class_name: 'Transact'
  def as_json(options = {})
    super(options.merge({ except: %i[password_digest created_at updated_at] }))
  end
end
