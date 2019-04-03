# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do
  # scenario（itのalias）の中に、確認したい各項目のテストの処理を書きます。
  scenario "タスク一覧のテスト" do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    Task.create!(title: 'test_task_01', content: 'testtesttest')
    Task.create!(title: 'test_task_02', content: 'samplesample')

    # tasks_pathにvisitする（タスク一覧ページに遷移する）
    visit tasks_path

    # visitした（到着した）expect(page)に（タスク一覧ページに）「testtesttest」「samplesample」という文字列が
    # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）テストを書いている
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samplesample'

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
    Task.create!(id: 999 , title: 'test_task_01', content: 'testtesttest' , deadline_at: '2019-04-01' , priority: '高', status: '未着手')

    visit task_path(999)

    # save_and_open_page
    expect(page).to have_content 'test_task_01'
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content '2019-04-01'
    expect(page).to have_content '高'
    expect(page).to have_content '未着手'

  end
end