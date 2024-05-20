# frozen_string_literal: true

module EventsUsers
  class LeaveEvent
    def initialize(event, user)
      @event = event
      @user = user
    end

    def call
      ActiveRecord::Base.transaction do
        @event.lock!
        return unless user_has_joined?

        @user.joined_events.destroy(@event)
        @event.available_slots = @event.available_slots + 1
        @event.save
      end
    end

    private

    def user_has_joined?
      @user.joined_events.exists?(@event.id)
    end
  end
end
