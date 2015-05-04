class SchedulesHaveAndBelongToManyBatches < ActiveRecord::Migration
  def change
  	create_table :schedules_batches, :id => false do |t|
         t.belongs_to :schedule
         t.belongs_to :batch
    end
  end
end
