module Grocery
  class App < Sinatra::Base
    set :root, Grocery.root
    enable  :method_override

    set :sprockets, Sprockets::Environment.new(root) { |env|
      env.append_path(root.join('app', 'assets', 'stylesheets'))
      env.append_path(root.join('app', 'assets', 'javascripts'))
      env.append_path(root.join('app', 'assets', 'images'))
    }

    configure :development do
      register Sinatra::Reloader
    end

    helpers do
      def redis
        Grocery.redis
      end

      def redis_namespace
        "grocery:#{Grocery::App.environment}:"
      end

      def asset_path(source)
        if Grocery.env.production?
          "/assets/" + settings.sprockets.find_asset(source).digest_path
        else
          "/assets/" + settings.sprockets.find_asset(source).logical_path
        end
      end
    end

    get '/' do
      erb :index
    end

    post '/lists' do
      list = List.new
      redirect "/lists/#{list.id}"
    end

    get '/lists/:id' do
      @id = params[:id]
      @items = redis.smembers "#{redis_namespace}:#{@id}"
      erb :list
    end

    post '/lists/:id/item' do
      unless params[:item].empty?
        redis.sadd "#{redis_namespace}:#{params[:id]}", params[:item]
      end
      redirect "lists/#{params[:id]}"
    end

    delete '/lists/:id/item' do
      redis.srem "#{redis_namespace}:#{params[:id]}", params[:item]
      redirect "lists/#{params[:id]}"
    end

    post '/lists/:id/clear' do
      redis.del "#{redis_namespace}:#{params[:id]}"
      redirect "lists/#{params[:id]}"
    end
  end
end