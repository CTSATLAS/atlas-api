class UserTransactionsController < ApplicationController
  def create
    if service_code
      code = ServiceCode.where(service_code: service_code).first

      if code.nil?
        error = {
          errors: [{
            title: 'not found',
            detail: 'service_code - not found',
            code: 100,
            status: 422
          }]
        }

        render json: error, status: :unprocessable_entity
        return
      else
        params['data']['attributes']['details'] = "#{code.service_code} - #{code.title}"
        params['data']['attributes'].delete('service_code')
      end
    end

    process_request
  end

  private

  def service_code
    params['data']['attributes']['service_code']
  end
end
