class LocationResource < JSONAPI::Resource
  attributes :id, :name, :public_name, :address_1, :address_2,
    :city, :state, :zip, :country, :telephone, :fax, :hidden, :hours
end
