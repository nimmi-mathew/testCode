module Api
    module Version1
      class StepsController < ApplicationController
        skip_before_action :verify_authenticity_token , raise: false
        def show
            name = params[:name].gsub('_',' ')
            chapter = Chapter.find_by_name(name)
            p ".................................#{chapter}"
            @steps = chapter.steps
            code_test = []
            @steps.each do |step|
              code_test << step.code_tests
            end
            render json: {status: 'SUCCESS', message:'Loaded steps', data:@steps, code:code_test},status: :ok
          end
          def index
          end
      end
    end
  end