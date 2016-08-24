require 'fileutils'

class QueuedDocumentsController < ApiController
  def create
    document_filename = generate_pdf_from_base64(encoded_file_string)
    QueuedDocument.create!(filename: document_filename, entry_method: 'API Upload')
    render json: { success: true }, status: :ok
  end

  private

  def encoded_file_string
    params['data']['attributes']['file']
  end

  def generate_pdf_from_base64(base64_string)
    decoded_string = Base64.decode64(base64_string)
    filename = generate_filename

    File.open("#{storage_folder}/#{filename}", 'wb') do |f|
      f.write(decoded_string)
    end

    filename
  end

  def storage_folder
    if Rails.env.development?
      storage_path = '/Users/brandoncordell/Code/atlas/storage/'
    else
      storage_path = '/var/www/vhosts/deploy/atlas/shared/storage/'
    end

    storage_path << "#{Date.today.year.to_s}/#{Date.today.strftime('%m').to_s}"

    unless File.exists? storage_path
      FileUtils::mkdir_p storage_path
    end

    storage_path
  end

  def generate_filename
    rand = Random.new
    "#{Date.today.strftime('%Y%m%d%H%I%S')}#{rand.rand(10**7)}.pdf"
  end
end
