class UserTransactionsController < ApplicationController
  def create
    if service_code
      code = ServiceCode.where(service_code: service_code).first
      params['data']['attributes']['details'] = "#{code.service_code} - #{code.title}"
      params['data']['attributes'].delete('service_code')
    end

    process_request
  end

  private

  def service_code
    params['data']['attributes']['service_code']
  end
end
