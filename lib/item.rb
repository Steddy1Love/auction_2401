class Item
    attr_reader :name, :bids

    def initialize(name)
        @bids = {}
        @name = name
    end

    def add_bid(attendee, amount)
        @bids.store(attendee, amount)
        attendee.add_attendees_items(self)
    end

    def current_high_bid
        high_bid = []
        high_bid = @bids.max_by{|attendee, amount| amount}
        high_bid ? high_bid[1] : 0
    end
end