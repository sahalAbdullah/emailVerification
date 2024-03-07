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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sahalAbdullah/emailVerification. Please provide detailed descriptions and steps to reproduce any bugs you encounter.

## License

The Single Email Verification gem is available as open source under the terms of the MIT License. You are free to use and modify it as per your requirements.

## Code of Conduct

Everyone interacting in the EmailVerification project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/sahalAbdullah/emailVerification/blob/master/CODE_OF_CONDUCT.md).
