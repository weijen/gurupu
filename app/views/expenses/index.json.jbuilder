json.array!(@expenses) do |expense|
  json.extract! expense, :name, :cost, :tag_id
  json.set! :username, User.find(id=expense.user_id).name
  json.set! :date ,expense.date.to_date
  json.set! :id ,expense.slug
  json.set! :editable ,(@group.state == 'active') && (expense.user_id==current_user.id)
  json.set! :deleteable ,(@group.state == 'active') && (@group.owners.include?(current_user) || expense.user_id==current_user.id)
end
