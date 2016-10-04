class UserResource < JSONAPI::Resource
  attributes :id, :firstname, :lastname, :middle_initial, :surname, :ssn,
    :username, :role_id, :windows_username, :address_1, :city, :state, :county,
    :zip, :phone, :alt_phone, :gender, :dob, :email, :language, :ethnicity, :race,
    :veteran, :disability, :organization, :signature, :signature_data, :location_id,
    :id_card_number, :signature_created, :signature_modified, :created, :modified, :guardian,
    :guardian_signature, :guardian_signature_data, :last_kiosk_login

  before_create :assign_role

  filter :email
  filter :firstname
  filter :lastname

  def assign_role
    @model.role_id = 1
  end
end
