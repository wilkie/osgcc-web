require './osgcc_web'

api_keys_file = 'api_keys.yml'
api_keys      = YAML.load_file(api_keys_file)[ENV['RACK_ENV']]
api_keys.each{ |key, value| ENV[key] = value }

run OSGCCWeb
