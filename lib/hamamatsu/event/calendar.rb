require "hamamatsu/event/version"
require "nokogiri"
require "open-uri"

module Hamamatsu
  module Event
    class Calendar

    	@@base_url = "http://www.city.hamamatsu.shizuoka.jp"

  		def crawl
  			list = []
  			page = 1

  			begin
  				while(true) do
            break if page > 50

  					url = target_url(Time.now.year, month, page)
  					charset = nil
		  			html = open(url) do |f|
		  				charset = f.charset
		  				f.read
		  			end

  					doc = Nokogiri::HTML.parse(html, nil, charset)

  					listpage = doc.css("#tmp_contents #tmp_event_list li")
  					break if listpage.count <= 0

		  			list << listpage.map do |r|
		  				{
                title: r.text.gsub(/\s/, ""), 
                name: r.css("a").text.gsub(/\s/, ""), 
                date: parse_date(r.text),
                url: "#{@@base_url}#{r.css("a")[0][:href]}"
              }
		  			end

		  			page += 1
  				end
  			end

        list.flatten.select{|r| r[:date] > Date.today}
  		end

  		private 
  			def target_url year=2016,month=10,page=1
  				"#{@@base_url}/cgi-bin/event_cal/cal_month.cgi?year=#{year}&month=#{month}&page=#{page}"
  			end

        def parse_date text
          ret = text.match(/(?<year>(\d*))年(?<month>(\d*))月(?<day>(\d*))日/)
          Date.new(ret[:year].to_i, ret[:month].to_i, ret[:day].to_i)
        rescue
          nil
        end
    end
  end
end


if __FILE__ == $0
	require "awesome_print"
	require "pry"  

	client = Hamamatsu::Event::Calendar.new
	ap client.crawl
end
