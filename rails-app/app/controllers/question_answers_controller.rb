class QuestionAnswersController < ApplicationController
  before_action :set_question_answer, only: %i[ show edit update destroy answer_question ]

  # GET /question_answers or /question_answers.json
  def index
    @question_answers = QuestionAnswer.all
  end

  # GET /question_answers/1 or /question_answers/1.json
  def show
  end

  # GET /question_answers/new
  def new
    @submission = Submission.find(params[:submission_id])
    @question_answer = QuestionAnswer.new
  end

  # GET /question_answers/1/edit
  def edit
  end

  # POST /question_answers or /question_answers.json
  def create
    @question_answer = QuestionAnswer.new(question_answer_params)

    respond_to do |format|
      if @question_answer.save

        message = "asked author a question".downcase
        @question_answer.submission.add_to_history(current_user, message, category: "question_answer")

        SubmissionMailer.ask_author_a_question(user: User.find_by_email(@question_answer.submission.email), submission: @question_answer.submission, question_answer: @question_answer).deliver_now


        format.html {
          redirect_to submission_path(@question_answer.submission), notice: "question was successfully created."
        }
        format.json {
          render :show, status: :created, location: @question_answer
        }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @question_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /question_answers/1 or /question_answers/1.json
  def update
    respond_to do |format|
      if @question_answer.update(question_answer_params)
        format.html { redirect_to submission_path(@question_answer.submission), notice: "question was successfully updated." }
        format.json { render :show, status: :ok, location: @question_answer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question_answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_answers/1 or /question_answers/1.json
  def destroy
    @question_answer.destroy
    respond_to do |format|
      format.html { redirect_to question_answers_url, notice: "Question answer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def answer_question

    respond_to do |format|
      if @question_answer.update(question_answer_params)

        message = "answered a question".downcase
        @question_answer.submission.add_to_history(current_user, message, category: "question_answer")

        format.html { redirect_to my_submissions_submissions_path, notice: "question was successfully answered." }
        format.json { render :show, status: :ok, location: @question_answer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question_answer.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_answer
      @question_answer = QuestionAnswer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_answer_params
      params.require(:question_answer).permit(:question, :answer, :submission_id)
    end
end
