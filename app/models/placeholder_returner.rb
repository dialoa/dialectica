class PlaceholderReturner

  include Rails.application.routes.url_helpers

  def initialize(placeholder_name: "", submission: nil, user: nil, external_referee: nil, password: nil, question_answer: nil, author: nil)
    @placeholder_name = placeholder_name
    @submission = submission
    @user = user
    @external_referee = external_referee
    @password = password
    @question_answer = question_answer
    @author = author
  end


  def return_value
    return Submission.placeholders(@submission)[@placeholder_name.to_sym] unless Submission.placeholders(@submission)[@placeholder_name.to_sym].nil?
    return User.placeholders(@user)[@placeholder_name.to_sym] unless User.placeholders(@user)[@placeholder_name.to_sym].nil?
    return ExternalReferee.placeholders(@external_referee)[@placeholder_name.to_sym] unless ExternalReferee.placeholders(@external_referee)[@placeholder_name.to_sym].nil?
    return QuestionAnswer.placeholders(@question_answer)[@placeholder_name.to_sym] unless QuestionAnswer.placeholders(@question_answer)[@placeholder_name.to_sym].nil?
    return @password if @placeholder_name == "user.password"
    return ""
  end

end
