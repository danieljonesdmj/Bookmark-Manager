require 'pg'
require 'uri'

class Bookmark
  def self.switch_database
    if ENV['ENVIRONMENT'] == 'test'
      @connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      @connection = PG.connect(dbname: 'bookmark_manager')
    end
  end

  def self.all
    Bookmark.switch_database

    result = @connection.exec('SELECT * FROM bookmarks')
    result.map { |bookmark| { title: bookmark['title'], url: bookmark['url'] } }
  end

  def self.add(title, url)
    Bookmark.switch_database
    @connection.exec("INSERT INTO bookmarks (title, url) VALUES ('#{title}', '#{url}');")
  end

  def self.valid_url(url)
    url =~ /\A#{URI.regexp(%w[http https])}\z/
  end
end
