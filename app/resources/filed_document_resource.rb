class FiledDocumentResource < JSONAPI::Resource
  attributes :id, :filename, :download_url, :admin, :user, :scanned_location_id,
    :filed_location_id, :cat_1, :cat_2, :cat_3, :description, :entry_method,
    :last_activity_admin_id, :created, :modified, :filed

  filter :created_since, apply: -> (records, value, options) do
    db_time = Time.at(value.first.to_i).utc
    records.where('filed_documents.created >= ?', db_time)
  end

  def download_url
    "https://denver.atlasforworkforce.com/admin/filed_documents/view/#{@model.id}"
  end

  def admin
    @model.admin_id
  end

  def user
    @model.user_id
  end
end

