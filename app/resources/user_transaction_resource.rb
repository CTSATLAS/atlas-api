class UserTransactionResource < JSONAPI::Resource
  attributes :id, :user_id, :location, :module, :details, :notes, :due_date,
    :status, :assigned_to, :created

  filter :user_id
end
