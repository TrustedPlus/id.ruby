# Omniauth IdTrustedPlus

The [OmniAuth](https://github.com/intridea/omniauth) strategy for authenticating to [IDTrustedPlus](https://id.trusted.plus).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-idTrustedPlus', git: 'https://github.com/TrustedPlus/id.ruby.git'
```

And then execute:

    $ bundle

## Usage

### Rails

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :idTrustedPlus, ENV['IDTrustedPlus_APP_ID'], ENV['IDTrustedPlus_APP_SECRET']
end
```

### Gitlab

```ruby
    gitlab_rails['omniauth_enabled'] = true 
    gitlab_rails['omniauth_allow_single_sign_on'] = ['idTrustedPlus']
    gitlab_rails['omniauth_block_auto_created_users'] = false

    gitlab_rails['omniauth_providers'] = [
    {
        "name" => "idTrustedPlus",
        "app_id" => "your_client_id",
        "app_secret" => "your_client_secret",
        'args' => {
            scope: 'userprofile',
        }              
    }
]
```
## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
