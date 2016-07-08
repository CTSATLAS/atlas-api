class FiledDocumentResource < JSONAPI::Resource
  attributes :id, :filename, :created, :modified, :filed
end
