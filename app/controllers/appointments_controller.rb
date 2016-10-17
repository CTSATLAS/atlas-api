class AppointmentsController < ApiController
  def create
    job_seeker_log = {
      location_id: incoming_location_id,
      in_office: incoming_office_request,
      service_type_id: incoming_service_type_id,
      notes: incoming_notes,
      user_id: incoming_user_id,
      created: Time.now.to_s(:db),
      modified: Time.now.to_s(:db)
    }

    job_seeker_queue = JobSeekerQueue.new job_seeker_log

    if job_seeker_queue.save
      render json: { success: true }, status: :ok
    else
      errors = []

      job_seeker_queue.errors.messages.each do |field, error|
        detail = {
          title: error.first,
          detail: "#{field} - #{error.first}",
          code: 100,
          status: 422
        }
        errors << detail
      end

      render json: { errors: errors }, status: :unprocessable_entity
      return
    end
  end

  private

  def incoming_notes
    params['data']['attributes']['notes']
  end

  def incoming_location_id
    params['data']['attributes']['location_id']
  end

  def incoming_office_request
    params['data']['attributes']['in_office'] || 0
  end

  def incoming_service_type_id
    params['data']['attributes']['service_type_id']
  end

  def incoming_user_id
    params['data']['attributes']['user_id']
  end
end
