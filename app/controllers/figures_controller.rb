class FiguresController < ApplicationController

  get '/figures' do
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures' do
    figure = Figure.create
    figure.name = params['figure']['name'] if !!params['figure']['name']
    if !!params['figure']['title_ids']
      params['figure']['title_ids'].each do |title_id|
        figure.titles << Title.find(title_id)
      end
    end
    figure.titles << Title.create(name: params['title']['name']) if !!params['title']['name']
    if !!params['figure']['landmark_ids']
      params['figure']['landmark_ids'].each do |landmark_id|
        figure.landmarks << Landmark.find(landmark_id)
      end
    end
    figure.landmarks << Landmark.create(name: params['landmark']['name']) if !!params['landmark']['name']
    figure.save
    redirect '/figures'
  end
end
