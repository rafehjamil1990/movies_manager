# frozen_string_literal: true

module Events
  class DeleteEvent
    def initialize(event)
      @event = event
    end

    def call
      @event.destroy
      @event
    end
  end
end
