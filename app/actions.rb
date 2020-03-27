helpers do
    def current_user
        User.find_by(id: session[:user_id])
    end
end

def get_humanized_time_ago(time_ago_in_minutes)
    if time_ago_in_minutes >= 60
        "#{time_ago_in_minutes / 60} hours ago"
    else
        "#{time_ago_in_minutes} minutes ago"
    end
end

# The '/' Route

##################
#### HOMEPAGE ####
##################
get '/' do
    @finstagram_posts = FinstagramPost.order(created_at: :desc)
    return erb(:index)
end

get '/signup' do        # if a user navigates to the path "/signup",
    @user = User.new    # setup empty @user object
    return erb(:signup) # render "apps/views/signup.erb"
end

post '/signup' do

    # grab user input values from params
    my_email       = params[:email]
    my_avatar_url  = params[:avatar_url]
    my_username    = params[:username]
    my_password    = params[:password]
 
    # Instantiate a User
    @user = User.new({ email: my_email, avatar_url: my_avatar_url, username: my_username, password: my_password })

    # If user validation pass and user is saved.
    did_user_save = @user.save
    if did_user_save
        redirect to('/login')
    else
        return erb(:signup)
    end
end

# ###### LOGIN request
get '/login' do             # When a get request comes into /login
    return erb(:login)      # render /apps/view/login.erb
end

post '/login' do    # When we submit a form with action of /login
    username = params[:username]
    password = params[:password]

    @user = User.find_by(username: username)

    if @user && @user.password == password
        session[:user_id] = @user.id
        redirect to('/')
    else
        @error_message = "Login failed."
        erb(:login)
    end
end

get '/logout' do
    session[:user_id] = nil
    redirect to('/')
end

get '/finstagram_posts/new' do
    @finstagram_post = FinstagramPost.new
    erb(:'finstagram_posts/new')
end

post '/finstagram_posts' do
    photo_url = params[:photo_url]

    # Instantiate new FinstagramPost
    @finstagram_post = FinstagramPost.new({ photo_url: photo_url, user_id: current_user.id })

    # If @post validates, save.
    if @finstagram_post.save
        redirect(to('/'))
    else
        @finstagram_post.errors.full_messages.inspect
    end
end

get '/finstagram_posts/:id' do
    @finstagram_post = FinstagramPost.find(params[:id])
    return erb(:"finstagram_posts/show")
end

##################
#### FIZZBUZZ ####
##################
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

####################
#### YELLOWPAGE ####
####################
get '/yellow' do
    # Write a method that accepts a 10-character string of letters and outputs a corresponding phone number string. If the input letter string isn't 10 characters, you should return false (indicating that the input is not valid).
    my_old_string = "hellohello"
    
    return_string = get_phone_text(my_old_string)

    return return_string
end

    # Write a method that accepts a 10-character string of letters
    # Our method takes one argument.
    def get_phone_text(string_of_10_chars)

        # The output string, starts empty.  We'll add to it before returning it.
        returned_string_to_build = ""

        # If the input letter string isn't 10 characters in lenth return false
        is_string_10_chars_long = string_of_10_chars.length == 10
        if (!is_string_10_chars_long)
            return false
        end

        # outputs a corresponding number string
        # 2 -> A B C
        # 3 -> D E F
        # 4 -> G H I
        # 5 -> J K L
        # 6 -> M N O
        # 7 -> P Q R S
        # 8 -> T U V
        # 9 -> W X Y Z

        # Hash
        # keys = numbers
        # values = arrays of letters
        number_to_letter_hash = {
            "2": ["A", "B", "C"],
            "3": ["D", "E", "F"],
            "4": ["G", "H", "I"],
            "5": ["J", "K", "L"],
            "6": ["M", "N", "O"],
            "7": ["P", "Q", "R", "S"],
            "8": ["T", "U", "V"],
            "9": ["W", "X", "Y", "Z"]
        }

        # Hash
        # keys = letters
        # values = numbers
        letter_to_number_hash = {
            A: '2',
            B: '2',
            C: '2',
            D: '3',
            E: '3',
            F: '3',
            G: '4',
            H: '4',
            I: '4',
            J: '5',
            K: '5',
            L: '5',
            M: '6',
            N: '6',
            O: '6',
            P: '7',
            Q: '7',
            R: '7',
            S: '7',
            T: '8',
            U: '8',
            V: '8',
            W: '9',
            X: '9',
            Y: '9',
            Z: '9'
        }
        # make a "map" of letters to numbers

        for char_idx in 0..(string_of_10_chars.length - 1) do
            # we now have the number btween 1 and 10
            # get the letter in the string at "index" 0-9
            my_letter = string_of_10_chars[char_idx]

            # uppercase it!
            my_uppercase_letter = my_letter.upcase

            # Get the associated number:
            # fetch from a hash in Ruby
            my_number_to_add = letter_to_number_hash.fetch(my_uppercase_letter.to_sym)

            # Add the number we  found to the end of the string we're building
            returned_string_to_build = returned_string_to_build + my_number_to_add.to_s 
        end

        return returned_string_to_build
    end