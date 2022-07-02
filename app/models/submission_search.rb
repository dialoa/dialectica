class SubmissionSearch
  def initialize(search_string="")
    @search_string = search_string
  end

  def search
    Submission.ilike_search_field(@search_string)
  end
end
