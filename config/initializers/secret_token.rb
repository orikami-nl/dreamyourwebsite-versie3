# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
if !Rails.env.production?
	Dywsite2::Application.config.secret_token = "XDy4LtnNiQdo4RtC2fRUNVwQa1dnT1gx8ioqH5ZbLb88qCUapzDKYL8aw_NK9wz5y3xe9QmXcmd1KjyDOBEPjEXfa40uqW9JBXWeFcuELOi47aaMHijrRqu7y2wPok2l5XwPKKiBDRYZzhJdk5hvRRm+WSlbZcElV2ZrMbH8mJM"
else
	Dywsite2::Application.config.secret_token = ENV['SECRET_TOKEN']
end

