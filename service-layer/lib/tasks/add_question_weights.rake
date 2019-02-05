require_relative "../../config/environment"
require "json"

def send_updated_weights(course_id, quiz_id, questions, weights)
  questions.each do |question|
    question[:answers]&.each do |answer|
      if weights[answer[:id].to_s]
        answer[:weight] = weights[answer[:id].to_s].to_f
      end
    end
    puts Canvas::Quiz.put_quiz_question course_id, quiz_id, question
  end
end

def put_usage
  puts "USAGE: rake add_question_weights[:course_id, :quiz_id]"
end

task :add_question_weights, [:course_id, :quiz_id] do |_t, args|
  course_id = args.course_id
  quiz_id = args.quiz_id

  quiz = Canvas::Quiz.find course_id, quiz_id, nil
  q = quiz[:questions]

  if !course_id || !quiz_id
    put_usage
  else
    weights = Hash.new
    q.each do |question|
      puts "Question:"
      puts question[:question_text]
      question[:answers].each do |answer|
        puts "\tAnswer: " +
          answer[:text] + "\n\tCurrent weight is (" +
          answer[:weight].to_s +
          ").\n\tEnter for no change"
        w = STDIN.gets.chomp
        weights[answer[:id].to_s] = w.empty? ? answer[:weight] : w
      end
    end

    send_updated_weights(course_id, quiz_id, q, weights)
  end
end
