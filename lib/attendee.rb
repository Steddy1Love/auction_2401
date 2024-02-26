class Attendee
    attr_reader :name, 
                :budget,
                :items_bid_on
                

    def initialize(hash_data)
        @name = hash_data[:name]
        @budget = hash_data[:budget]
    end

    def items_bid_on 
        @items_bid_on || [] 
    end

    def add_attendees_items(item)
        @items_bid_on ||= []
        @items_bid_on << item
    end  
end