module Api
    module Version1
      class StepsController < ApplicationController
          def show
            chapter = Chapter.find_by_name(params[:name])
            p ".................................#{chapter}"
            @steps = chapter.steps
            render json: {status: 'SUCCESS', message:'Loaded steps', data:@steps},status: :ok
          end
          def index
          end
      end
    end
  end