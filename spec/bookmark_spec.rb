require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')
      connection.exec("INSERT INTO bookmarks (title, url) VALUES ('Google', 'http://google.com');")

      bookmarks = Bookmark.all
      expect(bookmarks).to include(title: 'Google', url: 'http://google.com')
    end
  end

  describe '.add' do
    it 'adds a new bookmark' do
      Bookmark.add('Makers Academy', 'http://makersacademy.com')
      bookmarks = Bookmark.all
      expect(bookmarks).to include(title: 'Makers Academy', url: 'http://makersacademy.com')
    end
  end
end
