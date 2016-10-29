require "spec_helper"

describe Hamamatsu::Event::Calendar do
  it "has a version number" do
    expect(Hamamatsu::Event::VERSION).not_to be nil
  end

  describe "#crawl" do
  	before do
  		@obj = Hamamatsu::Event::Calendar.new
  	end
  	it{ 
  		p @obj.crawl
  		expect(@obj.crawl).to include "events" 
  	}
  end
end
