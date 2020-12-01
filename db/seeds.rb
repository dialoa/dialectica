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

#submissions_with_different_dates.each_with_index do |submission, index|
#  Submission.create(title: submission, created_at: Date.today - index.weeks)
#end

#dead_submissions = [
#  "Aristotelian Metaphysics",
#  "Metaphysics without Thought Experiments"
#]

#dead_submissions.each_with_index do |submission, index|
#  Submission.create(title: submission, created_at: Date.today - 20.weeks, firstname: "Manfred", lastname: "Meier", dead: "true")
#end

reviewers = [{"mail"=>"andrea.giananti@unifr.ch", "first_name"=>"Andrea", "last_name"=>"Giananti"}, {"mail"=>"arturs.logins@uzh.ch", "first_name"=>"Arturs", "last_name"=>"Logins"}, {"mail"=>"Claudio.Calosi@unige.ch", "first_name"=>"Claudio", "last_name"=>"Calosi"}, {"mail"=>"catharine.diehl@utoronto.ca", "first_name"=>"Catharine", "last_name"=>"Diehl"}, {"mail"=>"weibel@philos.uzh.ch", "first_name"=>"Christian", "last_name"=>"Weibel"}, {"mail"=>"davoodbahjat@gmail.com", "first_name"=>"Davood", "last_name"=>"Bahjat"}, {"mail"=>"donnchadh.oconaill@unifr.ch", "first_name"=>"Donnchadh", "last_name"=>"O'Conaill"}, {"mail"=>"D.Vanello.1@warwick.ac.uk", "first_name"=>"Daniel", "last_name"=>"Vanello"}, {"mail"=>"edgar.phillips@gmail.com", "first_name"=>"Edgar", "last_name"=>"Phillips"}, {"mail"=>"fabrice.correia@unige.ch", "first_name"=>"Fabrice", "last_name"=>"Correia"}, {"mail"=>"francois.pellet@uni-muenster.de", "first_name"=>"François", "last_name"=>"Pellet"}, {"mail"=>"Fabrice.Teroni@unige.ch", "first_name"=>"Fabrice", "last_name"=>"Teroni"}, {"mail"=>"giova_merlo@yahoo.it", "first_name"=>"Giovanni", "last_name"=>"Merlo"}, {"mail"=>"julien.dutant@kcl.ac.uk", "first_name"=>"Julien", "last_name"=>"Dutant"}, {"mail"=>"joerg.loeschke@philos.uzh.ch", "first_name"=>"Jörg", "last_name"=>"Löschke"}, {"mail"=>"jan.plate@gmail.com", "first_name"=>"Jan", "last_name"=>"Plate"}, {"mail"=>"jonaswaechter@yahoo.com", "first_name"=>"Jonas", "last_name"=>"Waechter"}, {"mail"=>"matthias.egg@philo.unibe.ch", "first_name"=>"Matthias", "last_name"=>"Egg"}, {"mail"=>"maria.scarpati@unine.ch", "first_name"=>"Maria", "last_name"=>"Scarpati"}, {"mail"=>"mike.stuart.post@gmail.com", "first_name"=>"Mike", "last_name"=>"Stuart"}, {"mail"=>"nemo.krueger@stud.unilu.ch", "first_name"=>"Nemo", "last_name"=>"Krüger"}, {"mail"=>"philipp.blum@philosophie.ch", "first_name"=>"Philipp", "last_name"=>"Blum"}, {"mail"=>"patrik.engisch@unifr.ch", "first_name"=>"Patrik", "last_name"=>"Engisch"}, {"mail"=>"Paolo.Natali@unige.ch", "first_name"=>"Paolo", "last_name"=>"Natali"}, {"mail"=>"Robert.Michels@unige.ch", "first_name"=>"Robert", "last_name"=>"Michels"}, {"mail"=>"sharon.casu@unifr.ch", "first_name"=>"Sharon", "last_name"=>"Casu"}, {"mail"=>"hirvonen.philosophy@gmail.com", "first_name"=>"Sanna", "last_name"=>"Hirvonen"}, {"mail"=>"sebastian.muders@ethik.uzh.ch", "first_name"=>"Sebastian", "last_name"=>"Muders"}, {"mail"=>"Stephanie.Rennick@glasgow.ac.uk", "first_name"=>"Stephanie", "last_name"=>"Rennick"}, {"mail"=>"sandro.raess@philosophie.ch", "first_name"=>"Sandro", "last_name"=>"Räss"}, {"mail"=>"thomas.schindler1980@gmail.com", "first_name"=>"Thomas", "last_name"=>"Schindler"}, {"mail"=>"zoe.christoff@gmail.com", "first_name"=>"Zoé", "last_name"=>"Christoff"}]

reviewers.each do |reviewer|
  #acronym = reviewer.first.split(/ |-/).map(&:first).join.downcase
  new_user = User.create(email: reviewer["mail"], password: "epikur", password_confirmation: "epikur", firstname: reviewer["first_name"], lastname: reviewer["last_name"])
  new_user.roles << Role.find_by_name("reviewer")
  new_user.roles << Role.find_by_name("author")
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

fresh_submissions = [
{
	"id": 4061,
	"date": "23.4.2020",
	"title": "Internal Intentionalism and the understanding of emotion experience",
	"file_name": "4061.pdf"},
{
	"id": 4080,
	"date": "24.6.2020",
	"title": "A New Contact Paradox",
	"file_name": "4080.pdf"},
{
	"id": 4005,
	"date": "20.12.2019",
	"title": "A New View of Self-Constitution",
	"file_name": "4005.pdf"},
{
	"id": 4096,
	"date": "03.07.2016",
	"title": "Focus effects in number sentences revisited",
	"file_name": "4096.pdf"},
{
	"id": 4109,
	"date": "20.8.2020",
	"title": "In Defense of the Content-Priority View of Emotion",
	"file_name": "4109.pdf"},
{
	"id": 4112,
	"date": "19.8.2020",
	"title": "The Mental States First Theory of Promising",
	"file_name": "4112.pdf"},
{
	"id": 4120,
	"date": "03.8.2016",
	"title": "Time Travel and Ability",
	"file_name": "4120.pdf"},
{
	"id": 4123,
	"date": "08.8.2016",
	"title": "Realism, Naturalism, and Hazlett’s Challenge concerning Epistemic Value",
	"file_name": "4123.pdf"},
{
	"id": 4132,
	"date": "25.9.2020",
	"title": "Molefe on the Value of Community for Personhood",
	"file_name": "4132.pdf"},
{
	"id": 4058,
	"date": "13.5.2020",
	"title": "Boghossian, Bellarmine and Galileo: historical evidence for epistemic relativism",
	"file_name": "4058.pdf"}
]

fresh_submissions.each do |submission|
  sub = Submission.create(title: submission[:title], id: submission[:id], created_at: Date.parse(submission[:date]))
  sub.file.attach(io: File.open("#{Rails.root}/public/submissions/#{submission[:file_name]}"), filename: submission[:file_name])
end

#@message.image.attach(io: File.open('/path/to/file'), filename: 'file.pdf', content_type: 'application/pdf')
