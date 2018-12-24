json.data do
  json.array! @results do |result|
    json.partial! "result", locals: { result: result }
  end
end
json.meta do
  json.pagination do
    json.current_page @results.current_page
    json.next_page @results.next_page
    json.per_page @results.per_page
    json.previous_page @results.previous_page
    json.total_pages @results.total_pages
    json.total_count @results.total_entries
  end
end
