require_relative '../../config/environment'
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
        question: question.except("quiz_id", "id")
    }

    options = base_options.merge(body: q.to_json)
    options[:headers]["Content-Type"] = "application/json"
    uri = base_uri("/courses/#{course_id}/quizzes/#{quiz_id}/questions/#{question['id']}")
    HTTParty.put(uri, options)
end

def map_questions(questions)
    questions.map{|q| {
        question: q["question_text"],
        answers: q["answers"].map{ |a| {
            id: a["id"],
            text: a["text"],
            weight: a["weight"]
        }}
    }
    }.flatten
end

course_id = ARGV[0]
quiz_id = ARGV[1]
map = ARGV[2]

q = get_quiz_questions(course_id, quiz_id)
if(!course_id or !quiz_id)
    puts "USAGE: add_question_weights :course_id :quiz_id [:weight_map]\n"\
        "\t:weight_map\tan optional parameter of the form \'{\"9032\": 25}\'\" \n\t\t\t"\
        "where the hash key is the answer id and the value is the weight.\n\t\t\t"\
        "If not specified the script will return all questions and answers\n\t\t\t"\
        "for the specified quiz."
elsif(!map) 
    pp map_questions(q)
else
    revised_questions = []
    weights = JSON.parse(map)
    q.each do |question|
        if (question["answers"])
            question["answers"].each do |answer|
                if(weights[answer["id"].to_s])
                    answer["weight"] = weights[answer["id"].to_s]
                    puts put_quiz_question(course_id, quiz_id, question)
                end
            end
        end
    end
end