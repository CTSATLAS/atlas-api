class DownloadsController < ApiController
  def download
    document = FiledDocument.find(params[:id])
    send_file get_full_path(document.filename), type: 'application/pdf', status: :ok
  end

  private

  def get_full_path(filename)
    storage_path = if Rails.env.development?
                    '/Users/brandoncordell/Code/atlas/storage'
                   else
                    '/var/www/vhosts/deploy/atlas/shared/storage'
                   end


    "#{storage_path}/#{filename[0..3]}/#{filename[4..5]}/#{filename}"
  end
end
