%I[Finance Communications Management Marketing Strategy Video Podcast
   Infographic Assessment Discussion Tools Short Medium Long].each do |tag|
  ActsAsTaggableOn::Tag.find_or_create_by!(name: tag)
end
