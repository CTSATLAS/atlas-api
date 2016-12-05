class UserTransactionResource < JSONAPI::Resource
  attributes :id, :user_id, :location, :module, :details, :notes,
    :status, :created

  filter :user_id
end
