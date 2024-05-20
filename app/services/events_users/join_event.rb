# frozen_string_literal: true

module EventsUsers
  class JoinEvent
    def initialize(event, user)
      @event = event
      @user = user
    end

    def call
      ActiveRecord::Base.transaction do
        @event.lock!

        if @event.available_slots.zero?
          @event.errors.add(:base, 'Unable to join event. No available slots.')
          return @event
        end

        @user.joined_events << @event
        @event.available_slots = @event.available_slots - 1
        @event.save
        @event
      end
    end
  end
end
