feature 'view bookmarks' do
  scenario 'view bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("INSERT INTO bookmarks VALUES(1, 'http://google.com', 'Google');")

    visit('/')
    expect(page).to have_content 'Google'
  end
end
