require 'rails_helper'

RSpec.feature "会員登録機能", type: :feature do
 
  scenario "会員登録成功" do

    visit new_user_path

    fill_in 'user[name]', with: 'テスト'
    fill_in 'user[mail]', with: 'test@co.jp'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'

    click_on '登録'

    expect(page).to have_content '会員登録しました'
    expect(page).to have_content 'タスク一覧'

  end

  scenario "会員登録失敗" do

    visit new_user_path

    fill_in 'user[name]', with: 'テスト'
    fill_in 'user[mail]', with: 'test@co.jp'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '1234567'

    click_on '登録'

    expect(page).to have_content 'エラーがあります'

  end

end

RSpec.feature "ログイン・ログアウト機能", type: :feature do

  background do
    FactoryBot.create(:user)
  end

  scenario "ログイン成功" do
    visit new_session_path

    fill_in 'session[mail]', with: 'test1@co.jp'
    fill_in 'session[password]', with: '111111'

    click_on '登録'

    expect(page).to have_content 'ログインに成功しました'
    expect(page).to have_content 'タスク一覧'
  end

  scenario "ログイン失敗" do
    visit new_session_path
    
    fill_in 'session[mail]', with: 'test1@co.jp'
    fill_in 'session[password]', with: '11111'

    click_on '登録'

    expect(page).to have_content 'ログインに失敗しました'
  end

end

RSpec.feature "ページ遷移", type: :feature do

  background do
    FactoryBot.create(:user)
    FactoryBot.create(:second_user)
  end

  scenario "ログイン時、ユーザー登録画面に遷移しようとするとタスク一覧に遷移すること" do

    visit new_session_path

    fill_in 'session[mail]', with: 'test1@co.jp'
    fill_in 'session[password]', with: '111111'

    click_on '登録'

    visit new_user_path

    expect(page).to have_content 'タスク一覧'
  end

  scenario "ログイン時、自身以外のマイページへ遷移できないこと" do

    visit new_session_path

    fill_in 'session[mail]', with: 'test2@co.jp'
    fill_in 'session[password]', with: '111111'

    click_on '登録'

    visit user_path(3)

    expect(page).to have_content '別ユーザーの詳細画面へは遷移できません'
  end

  scenario "未ログイン時、タスク一覧に遷移できないこと" do

    visit tasks_path

    expect(page).to have_content 'ログイン'
  end

end
  
RSpec.describe "Userバリデーションチェック", type: :model do
  it "nameが空ならバリデーションが通らない" do
    user = User.new(name: '', mail: '1@co.jp' , password:'111111' , password_confirmation:'111111')
    expect(user).not_to be_valid
  end

  it "mailが空ならバリデーションが通らない" do
    user = User.new(name: 'test', mail: '' , password:'111111' , password_confirmation:'111111')
    expect(user).not_to be_valid
  end

  it "パスワードが空ならバリデーションが通らない" do
    user = User.new(name: 'test', mail: '1@co.jp' , password:'' , password_confirmation:'111112')
    expect(user).not_to be_valid
  end

  it "パスワード（確認用）が空ならバリデーションが通らない" do
    user = User.new(name: 'test', mail: '1@co.jp' , password:'111111' , password_confirmation:'')
    expect(user).not_to be_valid
  end

  it "mailがmail形式でなければバリデーションが通らない" do
    user = User.new(name: 'test', mail: 'test' , password:'111111' , password_confirmation:'111111')
    expect(user).not_to be_valid
  end

  it "パスワードが一致していなければバリデーションが通らない" do
    user = User.new(name: 'test', mail: '1@co.jp' , password:'111111' , password_confirmation:'111112')
    expect(user).not_to be_valid
  end

  it "nameが20字以上ならバリデーションが通らない" do
    user = User.new(name: 'あ' * 21, mail: '1@co.jp' , password:'111111' , password_confirmation:'111111')
    expect(user).not_to be_valid
  end

  it "パスワードが６字以下ならバリデーションが通らない" do
    user = User.new(name: 'あ', mail: '1@co.jp' , password:'11111' , password_confirmation:'11111')
    expect(user).not_to be_valid
  end

end