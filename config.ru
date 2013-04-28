$LOAD_PATH << File.expand_path('lib')
require 'travis/lite/application'

::NewRelic::Agent.after_fork(:force_reconnect => true) if defined? Unicorn

require 'raven'

use Raven::Rack
run Travis::Lite::Application
