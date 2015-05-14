module Sinatra
  module Pages
    def self.registered(app)
      app.get '/' do

        erb :'pages/index'
      end

      app.get '/api.blendle/get-notes' do
        content_type :json
        notes = Note.all :order => :id.desc

        ' {
            "notes":
                ' + notes.extend(HAL::NotesRepresenter).to_json +
            '
        }'
      end

      app.get '/api.blendle/get-note/:id' do
        content_type :json
        note = Note.get params[:id]
        if !note.nil?
          note.extend(HAL::NoteRepresenter).to_json
        end


      end

      app.post '/api.blendle/save-note' do
        content_result = params[:data]

        puts "Test Content_result: " + content_result

        note = Note.new
        note.content = content_result
        note.created_at = Time.now
        note.updated_at = Time.now
        note.save
      end

    end
  end
  register Pages
end
