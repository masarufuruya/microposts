class Like < ActiveRecord::Base
    belongs_to :issueable, polymorphic: true
end
