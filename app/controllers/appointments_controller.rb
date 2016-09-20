class AppointmentsController < ApiController
  def create
    job_seeker_log = {
      location_id: incoming_location_id,
      office: incoming_office_request,
      service_type_id: incoming_service_type_id,
      user_id: incoming_user_id,
      created: Time.now.to_s(:db),
      modified: Time.now.to_s(:db)
    }

    JobSeekerQueue.create! job_seeker_log
    render json: { success: true }, status: :ok
  end

  private

  def incoming_location_id
    params['data']['attributes']['location_id']
  end

  def incoming_office_request
    params['data']['attributes']['office']
  end

  def incoming_service_type_id
    params['data']['attributes']['service_type_id']
  end

  def incoming_user_id
    params['data']['attributes']['user_id']
  end
end
