# frozen_string_literal: true

class ApiError < StandardError
  def initialize(message: nil, faraday_error_class: nil)
    super(message)
    @faraday_error_class = faraday_error_class
  end

  attr_reader :faraday_error_class
end
