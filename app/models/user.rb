class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: %i[github]

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_initialize
    if user.new_record? && user.valid_github_user?(auth.credentials.token)
      user.save
    end
    user
  end

  def valid_github_user?(token)
    client = Octokit::Client.new(access_token: token)
    org = ENV['GITHUB_ORG']

    begin
      user_login = client.user.login
      Rails.logger.info "GitHub User Login: #{user_login}"

      membership = client.org_membership(org, user: user_login)
      Rails.logger.info "GitHub Organization Membership: #{membership}"

      member = membership[:state] == 'active'
      Rails.logger.info "GitHub Organization Member Check: #{member}"
      member
    rescue Octokit::Error => e
      Rails.logger.error "Octokit Error: #{e.message}"
      false
    end
  end

end
