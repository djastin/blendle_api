
class Note
	include DataMapper::Resource
	property :id, Serial
	property :content, Text, :required => true
	property :complete, Boolean, :required => true, :default => false
	property :created_at, DateTime
	property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!

module HAL
  module NoteRepresenter
    include Roar::JSON::HAL
    
    property :id
    property :content
    property :complete
    property :created_at
    property :updated_at

    link :self do
      "http://localhost:3000/api.blendle/get-note/#{id}"
    end
  end
end

module HAL
  module NotesRepresenter
    include Representable::JSON::Collection

    items extend: NoteRepresenter
  end
end

note = Note.new(id: '1', content: 'hello', complete: true, created_at: 19920729, updated_at: 19920792)
note.extend(HAL::NoteRepresenter)
puts note.to_json


