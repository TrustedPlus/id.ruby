require "omniauth/idTrustedPlus/version"
require 'omniauth-oauth2'

module OmniAuth  
    module Strategies
        class IdTrustedPlus < OmniAuth::Strategies::OAuth2

            option :name, "idTrustedPlus"
            
            option :client_options, {
                    site:          "https://id.trusted.plus",
                    authorize_url: "/idp/sso/oauth/authorize",
                    token_url:     "/idp/sso/oauth/token",
                    user_info_url: "/trustedapp/rest/user/profile/get"
            }

            option :redirect_url

            uid { raw_info["id"] }

            extra do
                {:raw_info => raw_info}
            end
            
            info do
                {
                    'nickname' => raw_info['login'],
                    'name' => raw_info['data']['displayName'],
                    'email' => raw_info['data']['email'] ? raw_info['data']['email'] : nil,
                    'first_name' => raw_info['data']['givenName'] ? raw_info['data']['givenName'] : nil,
                    'last_name' => raw_info['data']['familyName'] ? raw_info['data']['familyName'] : nil,
                    'image': nil
                }
            end
            
            def raw_info
                access_token.options[:mode] = :query
                @raw_info ||= access_token.get('/trustedapp/rest/user/profile/get', params: { access_token: access_token.token }).parsed
            end

            def callback_url
                full_host + script_name + callback_path
            end

            def build_access_token
                options.token_params.merge!(:headers => {'Authorization' => basic_auth_header })
                super
            end

            def basic_auth_header
                "Basic " + Base64.strict_encode64("#{options[:client_id]}:#{options[:client_secret]}")
            end

        end
    end
end 