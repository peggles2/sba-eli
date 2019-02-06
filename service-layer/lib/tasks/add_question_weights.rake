require_relative "../../config/environment"
require "httparty"
require "json"

def base_uri(path)
  ENV["CANVAS_HOST"] + "/api/v1" + path
end

def session_token
  ENV["CANVAS_TOKEN"]
end

def canvas_host
  ENV["CANVAS_HOST"]
end

def base_options
  {
    headers: {
      "Authorization" => "Bearer " + session_token,
    },
  }
end

def get_quiz_questions(course_id, quiz_id)
  HTTParty.get(base_uri("/courses/#{course_id}/quizzes/#{quiz_id}/questions"), base_options)
end

def put_quiz_question(course_id, quiz_id, question)
  q = {
    quiz_id: question["quiz_id"],
    id: question["id"],
    question: question.except("quiz_id", "id"),
  }

  options = base_options.merge(body: q.to_json)
  options[:headers]["Content-Type"] = "application/json"
  uri = base_uri("/courses/#{course_id}/quizzes/#{quiz_id}/questions/#{question['id']}")
  HTTParty.put(uri, options)
end

def map_questions(questions)
  questions.map do |q|
    {
      question: q["question_text"],
      answers: q["answers"].map do |a|
                 {
                   id: a["id"],
                   text: a["text"],
                   weight: a["weight"],
                 }
               end,
    }
  end.flatten
end

def send_updated_weights(course_id, quiz_id, questions, weights)
  questions.each do |question|
    question["answers"]&.each do |answer|
      if weights[answer["id"].to_s]
        answer["weight"] = weights[answer["id"].to_s].to_f
      end
    end
    puts put_quiz_question(course_id, quiz_id, question)
  end
end

def put_usage
  puts "USAGE: rake add_question_weights[:course_id, :quiz_id, [:weight_map]] \n"\
        "\t:weight_map\tan optional parameter of the form \'{\"9032\": 25}\'\" \n\t\t\t"\
        "where the hash key is the answer id and the value is the weight.\n\t\t\t"\
        "If not specified the script will return all questions and answers\n\t\t\t"\
        "for the specified quiz."
end

task :add_question_weights, [:course_id, :quiz_id, :weight_map] do |_t, args|
  course_id = args.course_id
  quiz_id = args.quiz_id
  map = args.weight_map

  q = get_quiz_questions(course_id, quiz_id)
  if !course_id || !quiz_id
    put_usage
  elsif !map
    weights = Hash.new
    map_questions(q).each do |question|
      puts question[:question]
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
  else
    weights = JSON.parse(map)
    send_updated_weights(course_id, quiz_id, q, weights)
  end
end
