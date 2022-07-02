# frozen_string_literal: true

class User < ApplicationRecord
  has_many :repositories, dependent: :destroy

  def self.login_with_oauth(auth)
    user = find_or_initialize_by(email: auth.info.email)
    user.uid = auth.uid
    user.avatar = auth.info.image
    user.provider = auth.provider
    user.email = auth.info.email
    user.nickname = auth.info.name
    user.token = auth.credentials.token
    user
  end
end
