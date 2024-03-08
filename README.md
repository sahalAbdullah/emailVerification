# EmailVerification

The Single Email Verification Gem is a Ruby library that provides functionality to verify single email addresses. It allows you to easily integrate email verification into your Ruby applications.

## Installation

To install the gem, add the following line to your application's Gemfile:

    $ gem install 'SingleEmailVerification'

Install the gem and add to the application's Gemfile by executing:

    $ bundle nstall

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install SingleEmailVerification

## Usage

To use the Single Email Verification gem, require it in your Ruby code:

require 'emailVerification'

## Development

Then, create an instance of the EmailVerification::Client class and use its single_verify method to verify a single email address:

class ClientTest

    def initialize
        @client = EmailVerification::Client.new
    end

    def test_single_verify
        email = 'sahal.abdullah@mslm.io'
        resp = @client.single_verify(email)
        puts resp
    end

end

ClientTest.new.test_single_verify

To modify your ClientTest class to allow users to add their API key from the MSL cloud, you can implement a method to set the API key and use it when initializing the EmailVerification::Client. Here's the updated code:

require 'email_verification'

class ClientTest
def initialize(api_key = nil)
@api_key = api_key
@client = EmailVerification::Client.new(api_key: @api_key)
end

def set_api_key(api_key)
@api_key = api_key
@client = EmailVerification::Client.new(api_key: @api_key)
end

def test_single_verify
email = 'sahal.abdullah@mslm.io'
resp = @client.single_verify(email)
puts resp
end
end

# Example usage:

# Instantiate ClientTest with API key

client_test = ClientTest.new('your_api_key_here')

# Alternatively, set API key after instantiation

# client_test.set_api_key('your_api_key_here')

# Perform single email verification

client_test.test_single_verify

With this modification, users can provide their API key either during initialization or after instantiation using the set_api_key method. This gives them the flexibility to use their MSL cloud API key for unlimited hits.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sahalAbdullah/emailVerification. Please provide detailed descriptions and steps to reproduce any bugs you encounter.

## License

The Single Email Verification gem is available as open source under the terms of the MIT License. You are free to use and modify it as per your requirements.

## Code of Conduct

Everyone interacting in the EmailVerification project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/sahalAbdullah/emailVerification/blob/master/CODE_OF_CONDUCT.md).
