require 'rubygems'
require 'bundler'

Bundler.require
Dotenv.load unless ENV['TWITTER_CONSUMER_KEY']


TweetStream.configure do | config |
	config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
	config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
	config.oauth_token = ENV['TWITTER_OAUTH_TOKEN']
	config.oauth_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
	config.auth_method = :oauth
end

p "em run"
EM.run do
	EM.add_timer(5) do 
		# raise "Error!"
		EM.stop
	end

	p "em running."
	TweetStream::Client.new.on_error do | message |
		p message
	end.track('test') do | status | 
		p status.text
	end
end
p "em end"