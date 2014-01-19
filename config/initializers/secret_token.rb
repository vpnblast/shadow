# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Shadow::Application.config.secret_key_base = 'b9cc472c22af1a9876ac5919fa12c8559b389b5b0e8d32c45062b364df5eb08fda17ba25a389091142e49d983f016dc3d357db0617763dce25a67ee6ae878cf9'
