class Analytic
  include Mongoid::Document
  field :source, type: String
  field :time, type: Time, default: ->{ Time.now }
end
