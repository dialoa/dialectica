class PlaceholderReturner

  include Rails.application.routes.url_helpers

  def initialize(placeholder_name: "", submission: nil, user: nil, external_referee: nil)
    @placeholder_name = placeholder_name
    @submission = submission
    @user = user
    @external_referee = external_referee
  end


  def return_value
    return Submission.placeholders(@submission)[@placeholder_name.to_sym] unless Submission.placeholders(@submission)[@placeholder_name.to_sym].nil?
    return User.placeholders(@user)[@placeholder_name.to_sym] unless User.placeholders(@submission)[@placeholder_name.to_sym].nil?
    return ExternalReferee.placeholders(@external_referee)[@placeholder_name.to_sym] unless ExternalReferee.placeholders(@submission)[@placeholder_name.to_sym].nil?

    return ""
  end

end
