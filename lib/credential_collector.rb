# Single Sign On - Login
#
# Built as Sinatra Rack Middleware
# For docs and specs see project README.md
#
# Author: kapfenho
#

require 'haml'
require 'rack/contrib'
require 'sinatra/base'
require 'i18n'
require 'i18n/backend/fallbacks' 
require 'sinatra/support/i18nsupport'

class CredentialCollector < Sinatra::Base

  register Sinatra::I18nSupport
  use Rack::Locale
  I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)

  load_locales './locales'
  set :run, false
  set :public_dir, './public'
  set :views, './views'
  set :environment, :production

  helpers do
    def get_locale
      @env["HTTP_ACCEPT_LANGUAGE"][0,2]
    end

    def t(*args)
      I18n.t(*args)
    end
  end

  get '/int' do
    @error = t(params[:p_error_code], locale: get_locale) if params[:p_error_code]
    @request_id = params[:resource_url]  if params[:resource_url]
    @request_id = params[:request_id]    if params[:request_id]
    @oam_req    = params[:OAM_REQ]       if params[:OAM_REQ]
    
    haml :int, :format => :html5
  end

  get '/ret' do
    @error = t(params[:p_error_code], locale: get_locale) if params[:p_error_code]
    @request_id = params[:resource_url]  if params[:resource_url]
    @request_id = params[:request_id]    if params[:request_id]
    @oam_req    = params[:OAM_REQ]       if params[:OAM_REQ]
    
    haml :ret, :format => :html5
  end

  get '/error' do
    #  OAM error code, look up in defined list and display
    @error = t (params[:p_error_code] || 'OAM-9'), locale: get_locale
    haml :error, :format => :html5
  end

  get '/info' do
    haml :info, :format => :html5
  end

  post '/int' do
    @error = t(@env["HTTP_P_ERROR_CODE"], locale: get_locale) if @env["HTTP_P_ERROR_CODE"]
#    @errorP = t(params[:p_error_code], locale: get_locale) if params[:p_error_code]
    
    haml :int, :format => :html5
  end

  run! if app_file == $0
end

