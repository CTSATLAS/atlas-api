require 'fileutils'

class QueuedDocumentsController < ApiController
  def create
    document = generate_pdf_from_base64(encoded_file_string)
    file_and_queue_document(document)
  end

  private

  def queued_document_params
    params.require(:data).permit(:type, attributes: :file)
  end

  def encoded_file_string
    params['data']['attributes']['file']
  end

  def generate_pdf_from_base64(base64_string)
    decoded_string = Base64.decode64(base64_string)

    File.open("#{storage_folder}/#{generate_filename}", 'wb') do |f|
      f.write(decoded_string)
    end
  end

  def storage_folder
    if Rails.env.development?
      storage_path = '/Users/brandoncordell/Code/atlas/storage/'
    else
      storage_path = '/var/www/deploy/atlas/shared/storage/'
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

  def file_and_queue_document(document)
  end
end
