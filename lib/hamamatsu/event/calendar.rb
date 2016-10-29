require "hamamatsu/event/version"
require "nokogiri"
require "open-uri"

module Hamamatsu
  module Event
    class Calendar
  		def crawl
  			list = []
  			page = 1

  			begin
  				while(true) do
  					url = target_url(Time.now.year, Time.now.month, page)
  					charset = nil
		  			html = open(url) do |f|
		  				charset = f.charset
		  				f.read
		  			end

  					doc = Nokogiri::HTML.parse(html, nil, charset)

  					listpage = doc.css("#tmp_contents #tmp_event_list li")
  					break if listpage.count <= 0

		  			list << listpage.map do |r|
		  				{title: r.text, name: r.css("a").text, url: r.css("a")[0][:href] }
		  			end

		  			page += 1
  				end
  			end


  			list.flatten
  		end

  		private 
  			def target_url year=2016,month=10,page=1
  				"http://www.city.hamamatsu.shizuoka.jp/cgi-bin/event_cal/cal_month.cgi?year=#{year}&month=#{month}&page=#{page}"
  			end
    end
  end
end


if __FILE__ == $0
	require "awesome_print"
	require "pp"

	client = Hamamatsu::Event::Calendar.new
	ap client.crawl
end
