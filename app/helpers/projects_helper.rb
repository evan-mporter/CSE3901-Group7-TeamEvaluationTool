module ProjectsHelper
    def average_score(list)
        list.inject(0.0) {|result, f| result + f.quality + f.participation + f.disagreements} / list.size
    end
end
