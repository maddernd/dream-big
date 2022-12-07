require 'grape'

class PlansApi < Grape::API
  desc 'Allow retrieval of a Plan'
  get '/plans/:id' do
    # Auth

    plan = Plan.find(params[:id])
    present plan, with: Entities::PlansEntity
  end

  desc 'Allow creation of a Plan'
  params do
    requires :id, type: Integer, desc: 'ID of plan'
    requires :section_id, type: Integer, desc: 'section ID'
    requires :goal_id, type: Integer, desc: 'goal ID'
    requires :plan_text, type: String, desc: 'details of the plan'
  end
  post '/plans' do
    plan_parameters = ActionController::Parameters
      .new(params)
      .permit(
        :id,
        :section_id,
        :goal_id,
        :plan_text
      )

    # Auth...

    plan = Plan.create!(plan_parameters)

    present plan, with: Entities::PlansEntity
  end

  desc 'Allow updating of a Plan'
  params do
    requires :id, type: Integer, desc: 'ID of plan'
    optional :section_id, type: Integer, desc: 'section ID'
    optional :goal_id, type: Integer, desc: 'goal ID'
    optional :plan_text, type: String, desc: 'details of the plan'
  end
  put '/plans/:id' do
    plan_parameters = ActionController::Parameters
      .new(params)
      .permit(
        :section_id,
        :section_id,
        :goal_id,
        :plan_text
      )

    # Auth

    plan = Plan.find(params[:id])
    plan.update!(plan_parameters)

    present plan, with: Entities::PlansEntity
  end

  desc 'Delete the plan with the indicated id'
  params do
    requires :id, type: Integer, desc: 'ID of the plan'
  end
  delete '/plans/:id' do
    Plan.find(params[:id]).destroy!

    return true
  end

  desc 'Get all the plans'
  get '/plans' do
    plans = Plan.all

    present plans, with: Entities::PlansEntity
  end
end
