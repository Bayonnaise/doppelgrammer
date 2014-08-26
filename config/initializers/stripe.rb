Rails.configuration.stripe = {
	if Rails.env.production?
		:publishable_key => ENV['PRODUCTION_PUBLISHABLE_KEY'],
	  :secret_key      => ENV['PRODUCTION_SECRET_KEY']
	else
	  :publishable_key => ENV['TEST_PUBLISHABLE_KEY'],
	  :secret_key      => ENV['TEST_SECRET_KEY']
	end
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]