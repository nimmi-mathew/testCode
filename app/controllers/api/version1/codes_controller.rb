module Api
    module Version1
      class CodesController < ApplicationController
        skip_before_action :verify_authenticity_token , raise: false

        
        def post_ruby
            
            code = params[:code]
            step = params[:step]
            @step = Step.find(step)
            @valid = 0
            @step.code_tests.each do |test|
            code = validateCode(code)
            @testcode = code + "\n print " + test.input 
                t = testResult(@testcode)
                p"....................................#{t}"
              if t.to_s == test.output 
                 @valid += 1 
               end
       
               
           end
           render json: {status: 'SUCCESS', testPass: @valid},status: :ok
    end

    def validateCode(code)
     
      code = code.split("\n")
      code.delete_if {|w| w.include? "puts"}
      code.delete_if {|w| w.include? "print" }
      code.join("\n")
    end

    def testResult(code)
      require 'sicuro'
      p code
      @codeResult = Sicuro.eval(code)
      p "............................ #{@codeResult}"
      (@codeResult.stdout).gsub(/(?:\n\r?|\r\n?)/, '<br>')
    end
end
end
end