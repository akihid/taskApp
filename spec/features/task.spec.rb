# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do
  # scenario（itのalias）の中に、確認したい各項目のテストの処理を書きます。

  background do
    @user = FactoryBot.create(:user)
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    3.times do |i|
      Label.create!(id: i , word: "test#{i}")
    end

    visit new_session_path

    fill_in 'session[mail]', with: 'test1@co.jp'
    fill_in 'session[password]', with: '111111'

    click_on '登録'
  end

  scenario "タスク一覧のテスト" do

    # tasks_pathにvisitする（タスク一覧ページに遷移する）
    visit tasks_path

    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'testtesttest01'

  end

  scenario "タスク作成のテスト" do
    visit new_task_path

    fill_in 'task[title]', with: 'タイトル名のテスト'
    fill_in 'task[content]', with: '内容のテスト'
    click_on '登録'
    expect(page).to have_content 'タイトル名のテスト'
    expect(page).to have_content '内容のテスト'
    expect(page).to have_content '新規登録完了'
  end

  scenario "タスク詳細のテスト" do
    Task.create!(id: 999 , title: 'test_task_09', content: 'testtesttest' , deadline_at: Date.today + 5, priority: '高', status: '未着手',user_id: @user.id)

    visit task_path(999)

    expect(page).to have_content 'test_task_09'
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content  Date.today + 5
    expect(page).to have_content '高'
    expect(page).to have_content '未着手'

  end

  scenario "タスク並び順のテスト" do
    visit tasks_path
    # save_and_open_page
    # todo: tableタグ以外使用した場合エラーになる書き方。
    first_task = all('table tr td')[0]
    expect(first_task).to have_content 'test_task_03'
  end

  scenario "タスク並び順（終了期限）のテスト" do
    visit tasks_path

    select '終了期限でソートする', from: 'sort'
    click_on '検索'
    first_task = all('table tr td')[0]
    expect(first_task).to have_content 'test_task_01'
  end

  scenario "タスク並び順（優先順位）のテスト" do
    visit tasks_path

    select '優先順位でソートする', from: 'sort'
    click_on '検索'
    first_task = all('table tr td')[0]
    expect(first_task).to have_content 'test_task_01'
  end

end
 
RSpec.feature "タスク検索機能", type: :feature do

  background do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    3.times do |i|
      Label.create!(id: i , word: "test#{i}")
    end

    visit new_session_path

    fill_in 'session[mail]', with: 'test1@co.jp'
    fill_in 'session[password]', with: '111111'

    click_on '登録'
  end

  scenario "タスク検索（タスク名）のテスト" do
    visit tasks_path

    fill_in 'title', with: 'test_task_01'

    click_on '検索'
    expect(page).to have_content 'test_task_01'
    expect(page).to_not have_content 'test_task_02'
    expect(page).to_not have_content 'test_task_03'
  end

  scenario "タスク検索（状態）のテスト" do
    visit tasks_path

    select '完了', from: 'status'
    
    click_on '検索'
    expect(page).to_not have_content 'test_task_01'
    expect(page).to have_content 'test_task_02'
    expect(page).to have_content 'test_task_03'
    
  end

  scenario "タスク検索（タスク名と状態）のテスト" do
    visit tasks_path

    fill_in 'title', with: 'test_task_03'
    select '完了', from: 'status'

    click_on '検索'
    
    expect(page).to_not have_content 'test_task_01'
    expect(page).to_not have_content 'test_task_02'
    expect(page).to have_content 'test_task_03'
  end

end


RSpec.feature "タスク検索機能(ページャー）", type: :feature do

  background do

    @user = FactoryBot.create(:user)
    3.times do |i|
      Label.create!(id: i , word: "test#{i}")
    end
    visit new_session_path

    fill_in 'session[mail]', with: 'test1@co.jp'
    fill_in 'session[password]', with: '111111'

    click_on '登録'
  end
  scenario "ページャーテスト（次へ）" do

    30.times do |i|
      Task.create!(id: i , title: "test_task_#{i}", content: 'testtesttest' , deadline_at: Date.today , priority: '高', status: '未着手',user_id: @user.id)
    end

    visit tasks_path

    click_on '次 ›'
    first_task = all('table tr td')[0]
    expect(first_task).to have_content 'test_task_19'
  end

  scenario "ページャーテスト（最後へ）" do

    30.times do |i|
      Task.create!(id: i , title: "test_task_#{i}", content: 'testtesttest' , deadline_at: Date.today , priority: '高', status: '未着手',user_id: @user.id)
    end

    visit tasks_path
    
    click_on '最後 »'
    first_task = all('table tr td')[0]
    expect(first_task).to have_content 'test_task_9'
  end

  scenario "ページャーテスト（前へ）" do
    50.times do |i|
      Task.create!(id: i , title: "test_task_#{i}", content: 'testtesttest' , deadline_at: Date.today , priority: '高', status: '未着手',user_id: @user.id)
    end

    visit tasks_path
    
    click_on '最後 »'
    click_on '‹ 前'
    first_task = all('table tr td')[0]
    expect(first_task).to have_content 'test_task_19'
  end

  scenario "ページャーテスト（最初へ）" do

    50.times do |i|
      Task.create!(id: i , title: "test_task_#{i}", content: 'testtesttest' , deadline_at: Date.today , priority: '高', status: '未着手',user_id: @user.id)
    end

    visit tasks_path
    
    click_on '最後 »'
    click_on '« 最初'
    first_task = all('table tr td')[0]
    expect(first_task).to have_content 'test_task_49'
  end

end

RSpec.describe "タスクバリデーションチェック", type: :model do

  before do
    @user = FactoryBot.create(:user)
  end
  
  it "titleが空ならバリデーションが通らない" do
    task = Task.new(title: '', content: '失敗テスト',user_id: @user.id)
    expect(task).not_to be_valid
  end

  it "contentが空ならバリデーションが通らない" do
    task = Task.new(title: '失敗テスト', content: '',user_id: @user.id)
    expect(task).not_to be_valid
  end

  it "titleが20文字以上ならバリデーションが通らない" do
    task = Task.new(title: 'あ' * 21, content: '失敗テスト',user_id: @user.id)
    expect(task).not_to be_valid
  end

  it "contentが200文字以上ならバリデーションが通らない" do
    task = Task.new(title: '失敗テスト', content: 'あ' * 201,user_id: @user.id)
    expect(task).not_to be_valid
  end

  it "日付が過去ならバリデーションが通らない" do
    task = Task.new(title: '失敗テスト', content: '失敗テスト' , deadline_at: Date.today - 1 ,user_id: @user.id)
    expect(task).not_to be_valid
  end

  it "編集時に日付が過去でもバリデーションが通る" do
    task = FactoryBot.create(:task)
    task.update(deadline_at: Date.today - 1)
    expect(task).to be_valid

  end

  it "title20字以下、content200字以下で値が設定されていればバリデーションが通る" do
    task = Task.new(title: 'a' * 20, content: 'a' * 200, deadline_at: Date.today,user_id: @user.id)
    expect(task).to be_valid
  end
end