def log_in_with(email, password)
    visit login_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
  end

# For sessions_controller_spec.rb
  def log_in(user, opts={})
    remember_me = opts[:remember_me] || 1
    post :create, session: { email: user.email, password: user.password, remember_me: remember_me }
  end

