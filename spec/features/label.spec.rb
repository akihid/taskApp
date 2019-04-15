require 'rails_helper'

RSpec.feature "タグ機能", type: :feature do

  background do
    @user = FactoryBot.create(:user)
    3.times do |i|
      Label.create!(id: i , word: "test#{i}")
    end
    # FactoryBot.create(:label)
    # FactoryBot.create(:second_label)
    # FactoryBot.create(:third_label)
    visit new_session_path

    fill_in 'session[mail]', with: 'test1@co.jp'
    fill_in 'session[password]', with: '111111'

    click_on '登録'
  end

  scenario "タグ登録のテスト" do
    visit new_task_path
    fill_in 'task[title]', with: 'タイトル名のテスト'
    fill_in 'task[content]', with: '内容のテスト'
    check "task_label_id_1"
    check "task_label_id_2"
    
    click_on '登録'
    expect(TaskLabel.all.count).to eq(2)
  end

  scenario "タグ詳細のテスト" do
    visit new_task_path
    fill_in 'task[title]', with: 'タイトル名のテスト'
    fill_in 'task[content]', with: '内容のテスト'
    check "task_label_id_1"
    check "task_label_id_2"

    click_on '登録'
    click_on '詳細'
    
    expect(page).to have_content 'test1'
    expect(page).to have_content 'test2'
  end


end
 
RSpec.feature "タグ検索機能", type: :feature do

  background do
    @user = FactoryBot.create(:user)
    3.times do |i|
      Label.create!(id: i , word: "test#{i}")
    end
    visit new_session_path

    fill_in 'session[mail]', with: 'test1@co.jp'
    fill_in 'session[password]', with: '111111'

    click_on '登録'

    visit new_task_path

    fill_in 'task[title]', with: 'タイトル名のテスト'
    fill_in 'task[content]', with: '内容のテスト'
    check "task_label_id_1"
    check "task_label_id_2"

    click_on '登録'
  end

  scenario "タグ検索のテスト（データあり）" do
    visit tasks_path

    select 'test1', from: 'label'
    
    click_on '検索'
    expect(all('table tr').size).to eq(1)
    expect(page).to have_content 'タイトル名のテスト'
  end

  scenario "タグ検索のテスト（データなし）" do
    visit tasks_path

    select 'test0', from: 'label'
    
    click_on '検索'
    expect(all('table tr').size).to eq(0)
    expect(page).to_not have_content 'タイトル名のテスト'
  end

end
