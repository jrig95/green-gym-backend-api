json.array! @library_items do |library_item|
  json.extract! library_item, :id, :title
end
