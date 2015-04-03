class DashboardController < ApplicationController
respond_to :json
  def get_events
    @task = current_user.tasks
    events = []
    @task.each do |task|
      events << {:id => task.id, :title => "#{task.taskable.try(:name)} : #{task.task}", :start => "#{task.planned_start_date}",:end => "#{task.planned_end_date}" }
    end
    render :text => events.to_json
  end
end
