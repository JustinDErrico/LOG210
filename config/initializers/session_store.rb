# Be sure to restart your server when you modify this file.

#LOG210::Application.config.session_store :cookie_store, key: '_LOG210_session'

ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "railscasts.com",
    :user_name            => "mexicanexpressdelivery@gmail.com",
    :password             => "food1234",
    :authentication       => "plain",
    :enable_starttls_auto => true }

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# LOG210::Application.config.session_store :active_record_store
