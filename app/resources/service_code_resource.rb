class ServiceCodeResource < JSONAPI::Resource
  attributes :id, :title, :description, :service_code

  filter :service_code
end
