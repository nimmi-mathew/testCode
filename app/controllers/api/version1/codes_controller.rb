module Api
    module Version1
      class CodesController < ApplicationController
        skip_before_action :verify_authenticity_token , raise: false

        
        def post_ruby
            require 'sicuro'
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
    end

    def validateCode(code)
     
      code = code.split("\n")
      code.delete_if {|w| w.include? "puts"}
      code.delete_if {|w| w.include? "print" }
      code.join("\n")
    end

    def testResult(code)
      @codeResult = Sicuro.eval(code)
      CGI::escapeHTML(@codeResult.stdout.to_s).gsub(/(?:\n\r?|\r\n?)/, '<br>')
    end
end
end
end