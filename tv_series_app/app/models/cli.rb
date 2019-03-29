
require "colorize"
require "terminal-table"
require 'pry'


class CLI
    attr_reader :prompt

    def initialize
        @result = []
        @prompt = TTY::Prompt.new
    end

    # def welcome
    #     puts "*" * 25
    #     puts "Welcome to tv series app".green
    #     puts "*" * 25
    #     puts ""
    # end

    # def create_new_user
    #     puts "what is your name?".red
    #     name = gets.chomp
    #     @user = User.find_or_create_by(name: name)
        
        # new functionality

    def create_new_user
        name = @prompt.ask("what is your name?".red)
        @user = User.find_by(name: name)

        if @user
            # User.exists?(@user.name)
            puts "Welcome back #{@user.name}"
            show_current_series
            current_series 
            remove_from_series_list

        else
            @user= User.create(name: name)
            puts"Welcome #{@user.name}, to Tv series App".green
            input = get_user_input
        
            series_id = get_series_information(input)
            puts ""
        # binding.pry
        end
    end

    # def greet 
    #     puts""
    #     puts"Welcome #{@user.name}, to Tv series App".green
    # end

    def show_current_series
        puts""
        # puts "Welcome back #{@user.name}"
        puts "-" * 35
        puts "You have currently viewed: "
        @list = @user.series.each{ |s| puts s.name }
        puts"-" * 50
    end

    def current_series 
        @list = @user.series.map{ |s| s.name }
    
    end


    def remove_from_series_list
        
         result = @prompt.yes?("would you want to remove any series from your list?")

        if result
            puts ""
        # @prompt.ask("which one would you want to delete?")
            answer = @prompt.select("Ok. Choose one below:",@list )
            @series = Series.find_by(name: answer)
            @series.destroy
        else
            input = get_user_input
            series_id = get_series_information(input)
            view(@user.id, series_id)
            # get_series_information(series_name)
        end
       

        # binding.pry
        # 1
        # puts ("Ok. Choose one below:")
        # current_series
    end
        # End of new functionality test

    def get_user_input
        input = @prompt.ask("Enter a series_name:".red)
    end



    def get_series_information(series_name)
        url ="http://api.tvmaze.com/search/shows?q=#{series_name}"
        response = RestClient.get(url)
        data = JSON.parse(response)
        if data.empty?
            puts "Sorry, series not found".red
            input = get_user_input
            series_id = get_series_information(input)
            view(@user.id, series_id)
        
            
        else
            asterisk = ["-" * 60]
            info = data.first["show"]
            series = Series.find_or_create_by(name: series_name, series_type: info["type"], language: info["language"], runtime: info["runtime"], premiered: info["premiered"],officialsite: info["officialsite"])
            @result <<["The name of the series you entered: #{series_name}"]
            @result << asterisk
            @result <<["Type of series: #{info["type"]}".yellow]
            @result << asterisk
            @result <<["Language used: #{info["language"]}".blue]
            @result << asterisk
            @result <<["Run time: #{info["runtime"]}".cyan]
            @result << asterisk
            @result <<["Premiered: #{info["premiered"]}".yellow]
            @result << asterisk
            @result <<["Offical site: #{info["officialSite"]}".green]

            table = Terminal::Table.new :rows => @result
            puts table
            series.id
        end
    
    end

    def view(user_id, series_id)
        View.create(user_id: user_id, series_id: series_id)
    end


    
   

    def run
        # welcome
        create_new_user
        # greet 
        # show_current_series
        # current_series 
        # remove_from_series_list
        # input = get_user_input
        
        # series_id = get_series_information(input)
        # view(@user_id, series_id)
        # puts Series.series_runtime
        # puts Series.longest_series
        # puts Series.average_runtime
        #  binding.pry
    end
end
