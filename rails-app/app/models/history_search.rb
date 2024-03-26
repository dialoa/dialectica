class HistorySearch
  def initialize(search_string: "", submission: nil, user: nil, current_user: nil, last: nil)
    @search_string = search_string
    @submission = submission
    @user = user
    @current_user = current_user
    @last = last
    @histories = History.all
  end

  def search

    unless @search_string.blank?
      @histories = @histories.ilike_search_field(@search_string)
    end

    unless @submission.nil?
      @histories = @histories.where(submission_id: @submission.id)
    end

    unless @user.nil?
      @histories = @histories.where(user_id: @user.id)
    end

    unless @current_user.nil?
      @histories = @histories.where.not(submission_id: BlockedUser.where(user_id: @current_user.id).pluck(:submission_id))
    end

    unless @last.nil?
      @histories = @histories.last(@last)
    end


    @histories.order(created_at: :desc)

  end

end
