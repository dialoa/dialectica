class SubmissionSearch
  def initialize(search_string="")
    @search_string = search_string
  end

  def search
    Submission.all
  end
end
