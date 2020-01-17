# ルート
crumb :root do
  link "トップページ", root_path
end

# マイページ
crumb :mypage do
  link "マイページ", mypage_index_path
end

# プロフィール
crumb :profile do
  link "プロフィール", profile_mypage_index_path
  parent :mypage
end

# 支払い方法（新規カード登録）
crumb :card_index do
  link "支払い方法", card_index_path
  parent :mypage
end

# 支払い方法（カード情報）
crumb :card_new do
  link "クレジットカード情報入力", new_card_path
  parent :mypage
end

# 本人確認ページ
crumb :identification do
  link "本人情報の登録", identification_mypage_index_path
  parent :mypage
end

# ログアウト
crumb :logout do
  link "ログアウト", "logout"
  parent :mypage
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).