require 'grape'

class GoalsApi < Grape::API
  desc 'Allow retrieval of a Goal'
  get '/goals/:id' do
    # Auth

    goal = Goal.find(params[:id])
    present goal, with: Entities::GoalsEntity
  end

  desc 'Allow creation of a Goal'
  params do
    requires :id, type: Integer, desc: 'ID of goal'
    requires :section_id, type: Integer, desc: 'section ID'
    requires :description, type: String, desc: 'description of goal'
    requires :status, type: String, desc: 'status of goal'
  end
  post '/goals' do
    goal_parameters = ActionController::Parameters
                           .new(params)
                           .permit(
                             :id,
                             :section_id,
                             :description,
                             :status
                           )

    # Auth...

    created_goal = Goal.create!(goal_parameters)

    present created_goal, with: Entities::GoalsEntity
  end

  desc 'Allow updating of a Goal'
  params do
    requires :id, type: Integer, desc: 'ID of goal'
    optional :section_id, type: Integer, desc: 'section ID'
    optional :description, type: String, desc: 'description of goal'
    optional :status, type: String, desc: 'status of goal'
  end
  put '/goals/:id' do
    goal_parameters = ActionController::Parameters
                           .new(params)
                           .permit(
                             :section_id,
                             :description,
                             :status
                           )

    # Auth

    update_goal = Goal.find(params[:id])
    update_goal.update!(goal_parameters)

    present update_goal, with: Entities::GoalsEntity
  end

  desc 'Delete the Goal with the indicated id'
  params do
    requires :id, type: Integer, desc: 'ID of the goal'
  end
  delete '/goals/:id' do
    Goal.find(params[:id]).destroy!

    return true
  end

  desc 'Get all the goals'
  get '/goals' do
    goals = Goal.all

    present goals, with: Entities::GoalsEntity
  end
end
