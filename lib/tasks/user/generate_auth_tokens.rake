namespace :user do
  desc 'Generate auth token for old verified users.'
  task :generate_auth_tokens => [:environment] do
    if users_updated = User.where(auth_token: nil).where.not(verified_at: nil).update(auth_token: TokenHandler.generate_token)
      puts "Auth tokens generated for #{users_updated.size} users."
    end
  end
end
