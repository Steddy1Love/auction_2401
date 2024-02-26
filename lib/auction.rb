class Auction
    attr_reader :item, 
                :bidders,
                :bidders_name

    def initialize
        @item = []
        @bidders = []
        @bidders_name = []
    end

    def add_item(item)
        @item << item    
    end

    def item_names
        @item.map do |each_item|
            each_item.name
        end
    end
    
    def unpopular_items
        #lists items that do not have bids on them
        #if an item has a bid then remove from list
       @item.reject{|item| item.bids != {}}
    end

    def potential_revenue
        items_with_bids = []
        @item.map do |element|
            items_with_bids << element.current_high_bid
        end
        items_with_bids.sum
    end

    def add_bidder(attendee)
        @bidders << attendee
        @bidders_name << attendee.name
    end

    def bidder_info
        bidder_info_hash = {}
        @bidders.each do |attendee|
            attendee_info = {
                budget: attendee.budget,
                items: attendee.items_bid_on
            }
            bidder_info_hash[attendee] = attendee_info
        end
        require 'pry'; binding.pry
        bidder_info_hash
    end
end