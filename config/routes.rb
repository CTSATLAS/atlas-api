Rails.application.routes.draw do
  get 'filed_documents/:id/download' => 'downloads#download'

  resources :queued_documents, defaults: { format: :json }

  jsonapi_resources :document_filing_categories
  jsonapi_resources :filed_documents
  jsonapi_resources :service_types
end
