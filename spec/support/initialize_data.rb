# RSpec.shared_context 'initialize data' do
#   let(:test_label) { Label.find(RSpec.configuration.test_data[:label]) }
# end

# RSpec.configure do |config|
#   config.add_setting :test_data
#   config.test_data = {}

#   config.before :suite do
#     config.test_data[:label] = FactoryBot.create(:label).id
#   end

#   config.include_context 'initialize data'

#   config.after :suite do
#     Label.destroy_all
#   end
# end