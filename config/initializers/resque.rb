Dir["/app/app/jobs/*.rb"].each { |file| require file }
rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
rails_env = ENV['RAILS_ENV'] || 'development'
resque_config = YAML.load(ERB.new(File.new(rails_root + '/config/resque.yml.erb').read).result)
uri = URI.parse(resque_config[rails_env])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Resque.logger = Logger.new(Rails.root.join('log', "#{rails_env}_resque.log"))