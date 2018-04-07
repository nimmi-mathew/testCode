module Api
    module Version1
      class CodesController < ApplicationController
        skip_before_action :verify_authenticity_token , raise: false

        def ruby
        end
        def post_ruby
             require 'sicuro'
            @code = params[:code]
            @codeResult = Sicuro.eval(@code)
            p "######################################## #{@codeResult}"
            render json: {status: 'SUCCESS',  CGI::escapeHTML(@codeResult.stdout.to_s).gsub(/(?:\n\r?|\r\n?)/, '<br>')}
         end
      end
    end
end