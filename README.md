# Hamamatsu::Event::Calendar

浜松市公式サイトのイベントカレンダー(http://www.city.hamamatsu.shizuoka.jp/cgi-bin/event_cal/cal_month.cgi)より、当月分のイベント一覧を抽出する。


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hamamatsu-event-calendar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hamamatsu-event-calendar

## Usage

```
require "hamamatsu/event/calendar"

client= Hamamatsu::Event::Calendar.new
client.crawl
```

## Todo
