json.array! @library_items do |library_item|
  json.extract! library_item, :id, :title
  if library_item.video.attached?
    json.video_url library_item.video.service_url
  end

  if library_item.tag_list.present?
    json.tag_list library_item.tag_list
  end
end
