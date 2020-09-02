crumb :root do
  link "Home", root_path
end

crumb :category_index do
  link "カテゴリー一覧", categories_path
  parent :root
end

crumb :category do |item,category|
  if request.url.include?("categories")
    category = Category.find(params[:id])
    link "#{category.name}", category_path(category)
    parent :category_index 
  else
    item = Item.find(params[:id])
    category = Category.find(item.category_id)
    link "#{category.name}", category_path(category)
    parent :category_index 
  end
end

crumb :item do |item|
  item = Item.find(params[:id])
  link "#{item.name}", item_path(item)
  parent :category
end


# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).