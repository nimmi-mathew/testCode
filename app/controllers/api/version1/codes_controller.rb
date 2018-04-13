module Api
    module Version1
      class CodesController < ApplicationController
        skip_before_action :verify_authenticity_token , raise: false

        Rails.logger = Logger.new(STDOUT)
        
        #function thats invoked when the post request is placed
        def post_ruby
            
            code = params[:code]
            step = params[:step]
            @step = Step.find(step)
            @valid = 0
            @testCount = @step.code_tests.count
            @step.code_tests.each do |test|
            code = validateCode(code)
            @testcode = code + "\n print " + test.input 
            testResult = testResult(@testcode)
            logger.info"..............................#{testResult}"
                if testResult.to_s == test.output 
                 @valid += 1 
               end
       
               
           end
           @message = "#{@valid} out of #{@testCount} testcases passed"
           render json: {status: 'SUCCESS', testPass: @valid, testCount: @testCount, message:@message },status: :ok
        end
        #function to format the code
        def validateCode(code)
     
        code = code.split("\n")
        code.delete_if {|w| w.include? "puts"}
        code.delete_if {|w| w.include? "print" }
        code.join("\n")
        end
        #function to evaluate the formated code
        def testResult(code)
          require 'sicuro'
            logger.info"................................#{code}"
          @codeResult = Sicuro.eval(code)
          logger.info "............................ #{@codeResult}"
          (@codeResult.stdout).gsub(/(?:\n\r?|\r\n?)/, '<br>')
        end
      end
    end
end