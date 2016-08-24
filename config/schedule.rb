every 1.day, at: '11:00 am' do
  rake 'participants:download'
end

every 1.day, at: '11:30 am' do
  rake 'participants:import'
end
