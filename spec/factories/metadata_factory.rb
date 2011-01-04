

Factory.define :metadata do |f|


  f.display_name "example.txt"
  f.kind "Text document"
  
  f.content_type 'public.text'
  f.content_type_tree [ "public.text", 
                        "public.data", 
                        "public.item", 
                        "public.content" ]

end

Factory.define :audio, :parent => :metadata do |f| 
  
  
  f.display_name "06 Ego Tripping At The Gates Of Hell.mp3"
  f.kind "MP3 Audio File"
  f.title "Ego Tripping At The Gates Of Hell"
  
  f.audio_channel_count 2
  f.authors ["The Flaming Lips"]
  f.audio_track_number 6
  
  f.audio_bit_rate 160000
  f.content_type "public.mp3"
  f.audio_encoding_application "iTunes v4.6"
  f.recording_year 2002.0
  f.musical_genre "Alt Pop"
  f.total_bit_rate 160000
  f.album "Yoshimi Battles The Pink Robots"
  f.media_types ["Sound"]
  f.composer "Dave Fridmann/Michael Ivins/Steven Drozd/Wayne Coyne"
  f.content_type_tree [ "public.mp3", 
                        "public.audio", 
                        "public.audiovisual-content", 
                        "public.data", 
                        "public.item", 
                        "public.content" ]
  f.duration_seconds 4590246.5
  f.audio_sample_rate 44100.0

  
end