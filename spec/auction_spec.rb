require './lib/auction'
require './lib/item'
require './lib/attendee'

RSpec.describe Auction do
  before(:each) do
    @auction = Auction.new
    @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @item3 = Item.new('Homemade Chocolate Chip Cookies')
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')
  end

  describe '#initialize' do
    it 'exists' do
      expect(@auction).to be_a(Auction)
    end

    it 'has item array' do
        expect(@auction.item).to eq([])
    end

    it 'no attendees' do
        expect(@auction.bidders).to eq([])
    end
  end

  describe '#items' do
    it 'can add items' do
        @auction.add_item(@item1)
        expect(@auction.item).to eq([@item1])
    end

    it 'contains item names' do
        @auction.add_item(@item2)
        @auction.add_item(@item1)

        expect(@auction.item_names).to eq(['Bamboo Picture Frame', 'Chalkware Piggy Bank'])
    end

    it 'removes items from unpopular list when bid upon' do
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
        @auction.add_item(@item4)
        @auction.add_item(@item5)
        @item4.add_bid(@attendee3, 50)
        @item1.add_bid(@attendee2, 20)
        @item1.add_bid(@attendee1, 22)
        
        expect(@auction.unpopular_items).to eq([@item2, @item3, @item5])

        @item3.add_bid(@attendee2, 15)

        expect(@auction.unpopular_items).to eq([@item2, @item5])
    end
  end

  describe '#bidding' do
    it 'can determine revenue from highest bids' do
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
        @auction.add_item(@item4)
        @auction.add_item(@item5)
        @item3.add_bid(@attendee2, 15)
        @item4.add_bid(@attendee3, 50)
        @item1.add_bid(@attendee2, 20)
        @item1.add_bid(@attendee1, 22)

        expect(@auction.potential_revenue).to eq(87)
    end

    it 'has bidder info for the day' do
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
        @auction.add_item(@item4)
        @auction.add_item(@item5)
        @item3.add_bid(@attendee2, 15)
        @item4.add_bid(@attendee3, 50)
        @item1.add_bid(@attendee2, 20)
        @item1.add_bid(@attendee1, 22)
        @auction.add_bidder(@attendee1)
        @auction.add_bidder(@attendee2)
        @auction.add_bidder(@attendee3)

        expect(@auction.bidders).to eq([@attendee1, @attendee2, @attendee3])
        expect(@auction.bidder_info).not_to eq(nil)
    end
  end
end