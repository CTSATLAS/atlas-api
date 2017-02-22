class ImportsController < ApiController
  def create
    attrs = params['data']['attributes']
    extra_params = attrs.except(:firstname, :lastname, :ssn).to_json

    Import.create!(
      firstname: attrs[:firstname],
      lastname: attrs[:lastname],
      ssn: attrs[:ssn],
      extra_data: extra_params)
  end
end
