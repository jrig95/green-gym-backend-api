json.array! @program_library_items do |program_library_item|
  json.extract! program_library_item, :id, :pli_title
  if program_library_item.video.attached?
    json.video_url program_library_item.video.service_url
  end

  if program_library_item.tag_list.present?
    json.tag_list program_library_item.tag_list
  end

    if program_library_item.photo.attached?
      json.photo_url program_library_item.photo.service_url
    end
end
