class ProgramSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :program_description, :program_title, :photo
  def photo
    if object.photo.attached?
      {
        url: rails_blob_url(object.photo)
      }
    end
  end
end
