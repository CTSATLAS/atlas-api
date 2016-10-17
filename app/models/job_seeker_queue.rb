class JobSeekerQueue < ApplicationRecord
  self.table_name = 'job_seeker_logs'

  validates :user_id, presence: true
end
