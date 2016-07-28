class DocumentFilingCategoryResource < JSONAPI::Resource
  attributes :id, :parent_id, :name, :disabled

  filter :disabled, default: 0
end
