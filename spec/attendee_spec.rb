require './lib/auction'
require './lib/item'
require './lib/attendee'

RSpec.describe Attendee do
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
      expect(@attendee1).to be_a(Attendee)
    end

    it 'has attributes' do
        expect(@attendee1.name).to eq('Megan')
        expect(@attendee1.budget).to eq('$50')
        expect(@attendee1.items_bid_on).to eq([])
    end
  end

  describe '#bidding' do
    it 'stores items bid on' do
        @auction.add_item(@item1)
        @auction.add_item(@item2)
        @auction.add_item(@item3)
        @auction.add_item(@item4)
        @auction.add_item(@item5)
        @item4.add_bid(@attendee3, 50)
        @item1.add_bid(@attendee2, 20)
        @item1.add_bid(@attendee1, 22)

        expect(@attendee1.items_bid_on).to eq([@item1])
        expect(@attendee2.items_bid_on).to eq([@item1])
        expect(@attendee3.items_bid_on).to eq([@item4])
    end
  end
end