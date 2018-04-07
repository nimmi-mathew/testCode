class Step < ApplicationRecord
    belongs_to :chapter
    has_many :code_tests

    def to_param
        name
      end
end
