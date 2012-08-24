class Node < ActiveRecord::Base
  attr_accessible :input_type, :name, :output_type, :provider_id
  belongs_to :provider

  def input=(input)
    provider.inputs = input
  end

  def traversed?
    @traversed ||= false
  end

  def traverse
    @traversed = true
  end
end
