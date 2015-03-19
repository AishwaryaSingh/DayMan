class ProfessorSubject < ActiveRecord::Migration
  def change
  	create_table :professor_subject do |t|
  	  t.references :subject, :null => false
      t.references :professor, :null => false
    end

    add_index(:professor_subject, [:professor_id, :subject_id], :unique => true)
  end
end
