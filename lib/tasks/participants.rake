require 'csv'
require 'net/sftp'

logger = Logger.new('log/participants.log')

namespace :participants do
  desc "Download CSV of participants from Denver's server. Runs daily. See config/schedule.rb"
  task download: :environment do
    logger.info 'Downloading participants from rescareadmin.advantagesoftware.net'

    Net::SFTP.start('rescareadmin.advantagesoftware.net', 'atlasuser', password: 'roSldQMxydM2m') do |sftp|
      sftp.download!("/data/#{filename}", "#{Rails.public_path}/#{filename}")
    end
  end

  desc 'Import batch of participants. Runs daily after participants:download. See config/schedule.rb'
  task import: :environment do
    logger.info 'Importing participants'

    CSV.foreach("#{Rails.public_path}/#{filename}", headers: true) do |row|
      case_number = CaseNumber.where(number: row[4]).first_or_create!(number: row[4])
      parsed_dob = parse_dob(row[3])
      row[1].gsub!(/'/, '')
      row[2].gsub!(/'/, '')

      logger.info "checking: #{row[1]} #{row[2]}"

      if User.where(firstname: row[1], lastname: row[2], dob: parsed_dob).empty?
        User.create!(case_number_id: case_number.id, firstname: row[1], lastname: row[2], role_id: 1, dob: parsed_dob, created: datetime_now, modified: datetime_now)
      end
    end
  end
end

def filename
  "participants_#{todays_date}.csv"
end

def parse_dob(dob)
  unless dob.nil?
    #dob[-2, 2] == '01' ? dob.insert(-3, '20') : dob.insert(-3, '19') # Override century issues with 2 digit dates
    Date.strptime(dob, '%m/%d/%Y')
  end
end

def datetime_now
  DateTime.now.strftime('%Y-%m-%d %H:%I:%S')
end

def todays_date
  Date.today.strftime('%Y%m%d')
  '20160823'
end

