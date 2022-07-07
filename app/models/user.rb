class User < ApplicationRecord

  def password_digest=(val)
    self.encrypted_password = val
  end

  def password_digest
    encrypted_password
  end
end
