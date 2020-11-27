# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.roles.each do |role|
  Role.create(name: role)
end

admin = User.create(email: "admin@mail.com", password: "epikur", password_confirmation: "epikur", firstname: "Admin", lastname: "Admin")
admin.roles << Role.find_by_name("admin")
admin.roles << Role.find_by_name("editor")
admin.roles << Role.find_by_name("reviewer")
admin.roles << Role.find_by_name("author")

editor = User.create(email: "editor@mail.com", password: "epikur", password_confirmation: "epikur", firstname: "Editor", lastname: "Editor")
editor.roles << Role.find_by_name("editor")
editor.roles << Role.find_by_name("reviewer")
editor.roles << Role.find_by_name("author")

reviewer = User.create(email: "reviewer@mail.com", password: "epikur", password_confirmation: "epikur", firstname: "Reviewer", lastname: "Reviewer")
reviewer.roles << Role.find_by_name("reviewer")
reviewer.roles << Role.find_by_name("author")

author = User.create(email: "author@mail.com", password: "epikur", password_confirmation: "epikur", firstname: "Author", lastname: "Author")
author.roles << Role.find_by_name("author")

submissions_with_different_dates = [
  "On the Structures of Reality",
  "Categories and Substances",
  "If it is necessary, then it is also possible",
  "Scientific explanations and fiction",
  "Causality and Science",
  "How can Rationalism be refuted",
  "Is Kant a Kantian?",
  "To be or to have being, that is the question",
  "Frege and his philosophy of language",
  "What is a good metaethical theory?",
  "On Language and Logic",
  "What are Thought Experiments?",
  "Certainty and Truth",
  "On philosophical analysis"
]

submissions_with_different_dates.each_with_index do |submission, index|
  Submission.create(title: submission, created_at: Date.today - index.weeks)
end

dead_submissions = [
  "Aristotelian Metaphysics",
  "Metaphysics without Thought Experiments"
]

dead_submissions.each_with_index do |submission, index|
  Submission.create(title: submission, created_at: Date.today - 20.weeks, firstname: "Manfred", lastname: "Meier", dead: "true")
end

reviewers = ["Andrea Giananti","Arturs Logins","Claudio Calosi","Catharine Diehl","Christian Weibel","Davood Bahjat","Donnchadh O'Conaill","Daniel Vanello","Edgar Phillips","Fabrice Correia","François Pellet","Fabrice Teroni","Giovanni Merlo","Julien Dutant","Jörg Löschke","Jan Plate","Jonas Waechter","Matthias Egg","Maria Scarpati","Mike Stuart","Nemo Krüger","Philipp Blum","Patrik Engisch","Paolo Natali","Robert Michels ","Sharon Casu","Sanna Hirvonen","Sebastian Muders ","Stephanie Rennick","Sandro Räss","Thomas Schindler","Zoé Christoff"]

reviewers.each do |reviewer|
  acronym = reviewer.split(/ |-/).map(&:first).join.upcase
  new_user = User.create(email: acronym, password: acronym, password_confirmation: acronym, firstname: reviewer.split.first, lastname: reviewer.split.second)
  new_user.roles << Role.find_by_name("reviewer")
  new_user.roles << Role.find_by_name("author")
end

fresh_submissions = [
{
	"id": 4061,
	"date": "23.4.20",
	"title": "Internal Intentionalism and the understanding of emotion experience",
	"file_name": "4061.pdf"},
{
	"id": 4080,
	"date": "24.6.20",
	"title": "A New Contact Paradox",
	"file_name": "4080.pdf"},
{
	"id": 4005,
	"date": "20.12.19",
	"title": "A New View of Self-Constitution",
	"file_name": "4005.pdf"},
{
	"id": 4096,
	"date": "03.07.16",
	"title": "Focus effects in number sentences revisited",
	"file_name": "4096.pdf"},
{
	"id": 4109,
	"date": "20.8.20",
	"title": "In Defense of the Content-Priority View of Emotion",
	"file_name": "4109.pdf"},
{
	"id": 4112,
	"date": "19.8.20",
	"title": "The Mental States First Theory of Promising",
	"file_name": "4112.pdf"},
{
	"id": 4120,
	"date": "03.8.16",
	"title": "Time Travel and Ability",
	"file_name": "4120.pdf"},
{
	"id": 4123,
	"date": "08.8.16",
	"title": "Realism, Naturalism, and Hazlett’s Challenge concerning Epistemic Value",
	"file_name": "4123.pdf"},
{
	"id": 4132,
	"date": "25.9.20",
	"title": "Molefe on the Value of Community for Personhood",
	"file_name": "4132.pdf"},
{
	"id": 4058,
	"date": "13.5.20",
	"title": "Boghossian, Bellarmine and Galileo: historical evidence for epistemic relativism",
	"file_name": "4058.pdf"}
]

fresh_submissions.each do |submission|
  sub = Submission.create(title: submission[:title], id: submission[:id], created_at: Date.parse(submission[:date]))
  sub.file.attach(io: File.open("#{Rails.root}/public/#{submission[:file_name]}"))
end

#@message.image.attach(io: File.open('/path/to/file'), filename: 'file.pdf', content_type: 'application/pdf')
