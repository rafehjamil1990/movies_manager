# frozen_string_literal: true

module Events
  class CreateEvent
    def initialize(params, user)
      @params = params
      @user = user
    end

    def call
      event.assign_attributes(event_params)
      event.save
      event
    end

    private

    def event
      @event ||= @user.events.new
    end

    def event_params
      {
        available_slots: @params[:total_slots]
      }.merge(@params)
    end
  end
end
