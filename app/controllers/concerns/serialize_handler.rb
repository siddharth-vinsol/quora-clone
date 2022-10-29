module SerializeHandler
  def serialize_array_of_objects(objects, serializer)
    ActiveModelSerializers::SerializableResource.new(objects, { each_serializer: serializer })
  end
end
