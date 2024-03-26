class ScanAndSubstitute

  def initialize(content: "", submission: nil, user: nil, external_referee: nil, password: nil, question_answer: nil, author: nil)
    @content = content
    @submission = submission
    @user = user
    @external_referee = external_referee
    @password = password
    @question_answer = question_answer
    @author = author
  end

  def scan_and_substitute

    @content.scan(/(?<=\*\|)(.+?)(?=\|\*)/).each do |match|
      placeholder_name = match.first

      new_value = PlaceholderReturner.new(placeholder_name: placeholder_name, submission: @submission, user: @user, external_referee: @external_referee, password: @password, question_answer: @question_answer, author: @author).return_value

html_string = <<MARKER
#{new_value}
MARKER

    @content = @content.gsub(/\*\|#{placeholder_name}\|\*/, html_string)
    end

    @content

  end
end
