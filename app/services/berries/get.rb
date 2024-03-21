# frozen_string_literal: true

module Berries
  class Get < ApplicationService
    def initialize(berry_name, connection)
      @berry_name = berry_name
      @connection = connection
    end

    def call
      @connection.get_berry(@berry_name)
    end
  end
end
