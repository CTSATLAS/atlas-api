Rails.application.routes.draw do
  jsonapi_resources :document_filing_categories
  jsonapi_resources :filed_documents

  resources :queued_documents, defaults: { format: :json }
end
