# get '/' do
#   File.read(File.join('app/views', 'index.html'))
# end

def get_humanized_time_ago(time_ago_in_minutes)
    if time_ago_in_minutes >= 60
        "#{time_ago_in_minutes / 60} hours ago"
    else
        "#{time_ago_in_minutes} minutes ago"
    end
end

get '/' do
    finstagram_post_shark = {
        username: "sharky_j",
        avatar_url: "https://nascera.com/images/sharky_j.jpg",
        photo_url: "https://nascera.com/images/sharky.jpg",
        humanized_time_ago: get_humanized_time_ago(15),
        like_count: 0,
        comment_count: 1,
        comments: [{
            username: "sharky_j",
            text: "Out for the long weekend... too embarassed to show the beach bod!"
        }]
    }

    finstagram_post_whale = {
        username: "kirk_whalum",
        avatar_url: "https://nascera.com/images/kirk_whalum.jpg",
        photo_url: "https://nascera.com/images/whale.jpg",
        humanized_time_ago: get_humanized_time_ago(65),
        like_count: 0,
        comment_count: 1,
        comments: [{
            username: "kirk_whalum",
            text: "#weekendvibes"
        }]
    }

    finstagram_post_marlin = {
        username: "marlin_peppa",
        avatar_url: "https://nascera.com/images/marlin_peppa.jpg",
        photo_url: "https://nascera.com/images/marlin.jpb",
        humanized_time_ago: get_humanized_time_ago(190),
        like_count: 0,
        comment_count: 1,
        comments: [{
            username: "marlin_peppa",
            text: "lunchtime! ;)"
        }]
    }

    return [finstagram_post_shark, finstagram_post_shark, finstagram_post_marlin].to_s
end

get '/fizzbuzz' do
    my_string = ""

    for number in 1..100 do
        if number % 3 == 0 && number % 5 == 0
            my_string = my_string + "FizzBuzz <br/>"
        elsif number % 5 == 0
            my_string = my_string + "Buzz <br/>"
        elsif number % 3 == 0
            my_string = my_string + "Fizz <br/>"
        else
            my_string = my_string + "#{number} <br/>"
        end
        
    end

    return my_string
end