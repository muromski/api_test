class JobSerializer < ActiveModel::Serializer
  attributes :id, :title, :salary, :languages, :shifts
  def shifts
    object.shifts.to_json(only: %i[start_date finish_date])
  end
end
