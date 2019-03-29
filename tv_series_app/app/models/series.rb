class Series < ActiveRecord::Base
    has_many :views
    has_many :users, through: :views



    def self.series_runtime
        Series.all.map{|series|series.runtime}
    end

    def self.longest_series
        runtimes = Series.all.map{|series|series.runtime}.compact
        runtimes.max
    end


    def self.average_runtime
       total_series = Series.all.map{|series|series.runtime}.compact.sum
        series_length = Series.all.map{|s|s.runtime}.compact.length

        total_series.to_f / series_length.to_f
    end
end
    


