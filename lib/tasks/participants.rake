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
    inserts = []

    CSV.foreach("#{Rails.public_path}/#{filename}", headers: true) do |row|
      case_number = CaseNumber.where(number: row[4]).first_or_create!(number: row[4])

      row[1].gsub!(/'/, '')
      row[2].gsub!(/'/, '')
      inserts.push "(#{case_number.id}, '#{row[1]}', '#{row[2]}', 1, '#{parse_dob(row[3])}', '#{row[5]}', '#{datetime_now}', '#{datetime_now}')"
    end

    sql = "INSERT INTO users (`case_number_id`, `firstname`, `lastname`, `role_id`, `dob`, `address_1`, `created`, `modified`) VALUES #{inserts.join(', ')}"
    results = ActiveRecord::Base.connection.execute(sql)
  end
end

def filename
  "participants_#{todays_date}.csv"
  "participants_20160824.csv"
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
end

