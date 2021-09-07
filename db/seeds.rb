# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.roles.each do |role|
  Role.create(name: role) unless Role.where(name: role).exists?
end

#submissions_with_different_dates = [
#  "On the Structures of Reality",
#  "Categories and Substances",
#  "If it is necessary, then it is also possible",
#  "Scientific explanations and fiction",
#  "Causality and Science",
#  "How can Rationalism be refuted",
#  "Is Kant a Kantian?",
#  "To be or to have being, that is the question",
#  "Frege and his philosophy of language",
#  "What is a good metaethical theory?",
#  "On Language and Logic",
#  "What are Thought Experiments?",
#  "Certainty and Truth",
#  "On philosophical analysis"
#]

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

#reviewers = [
#  {"mail"=>"andrea.giananti@unifr.ch", "first_name"=>"Andrea", "last_name"=>"Giananti"},
#  {"mail"=>"arturs.logins@uzh.ch", "first_name"=>"Arturs", "last_name"=>"Logins"},
#  {"mail"=>"Claudio.Calosi@unige.ch", "first_name"=>"Claudio", "last_name"=>"Calosi"},
#  {"mail"=>"catharine.diehl@utoronto.ca", "first_name"=>"Catharine", "last_name"=>"Diehl"},
#  {"mail"=>"weibel@philos.uzh.ch", "first_name"=>"Christian", "last_name"=>"Weibel"},
#  {"mail"=>"davoodbahjat@gmail.com", "first_name"=>"Davood", "last_name"=>"Bahjat"},
#  {"mail"=>"donnchadh.oconaill@unifr.ch", "first_name"=>"Donnchadh", "last_name"=>"O'Conaill"},
#  {"mail"=>"d.vanello.1@warwick.ac.uk", "first_name"=>"Daniel", "last_name" =>"Vanello"},
#  {"mail"=>"edgar.phillips@gmail.com", "first_name"=>"Edgar", "last_name"=>"Phillips"},
#  {"mail"=>"fabrice.correia@unige.ch", "first_name"=>"Fabrice", "last_name"=>"Correia"}, {"mail"=>"francois.pellet@uni-muenster.de", "first_name"=>"François", "last_name"=>"Pellet"}, {"mail"=>"Fabrice.Teroni@unige.ch", "first_name"=>"Fabrice", "last_name"=>"Teroni"},
#  {"mail"=>"giova_merlo@yahoo.it", "first_name"=>"Giovanni", "last_name"=>"Merlo"},
#  {"mail"=>"julien.dutant@kcl.ac.uk", "first_name"=>"Julien", "last_name"=>"Dutant"},
#  {"mail"=>"joerg.loeschke@philos.uzh.ch", "first_name"=>"Jörg", "last_name"=>"Löschke"}, {"mail"=>"jan.plate@gmail.com", "first_name"=>"Jan", "last_name"=>"Plate"}, {"mail"=>"jonaswaechter@yahoo.com", "first_name"=>"Jonas", "last_name"=>"Waechter"},
#  {"mail"=>"matthias.egg@philo.unibe.ch", "first_name"=>"Matthias", "last_name"=>"Egg"},
#  {"mail"=>"maria.scarpati@unine.ch", "first_name"=>"Maria", "last_name"=>"Scarpati"},
#  {"mail"=>"mike.stuart.post@gmail.com", "first_name"=>"Mike", "last_name"=>"Stuart"}, {"mail"=>"nemo.krueger@stud.unilu.ch", "first_name"=>"Nemo", "last_name"=>"Krüger"}, {"mail"=>"philipp.blum@philosophie.ch", "first_name"=>"Philipp", "last_name"=>"Blum"},
#  {"mail"=>"patrik.engisch@unifr.ch", "first_name"=>"Patrik", "last_name"=>"Engisch"},
#  {"mail"=>"Paolo.Natali@unige.ch", "first_name"=>"Paolo", "last_name"=>"Natali"},
#  {"mail"=>"Robert.Michels@unige.ch", "first_name"=>"Robert", "last_name"=>"Michels"},
#  {"mail"=>"sharon.casu@unifr.ch", "first_name"=>"Sharon", "last_name"=>"Casu"},
#  {"mail"=>"hirvonen.philosophy@gmail.com", "first_name"=>"Sanna", "last_name"=>"Hirvonen"}, {"mail"=>"sebastian.muders@ethik.uzh.ch", "first_name"=>"Sebastian", "last_name"=>"Muders"}, {"mail"=>"Stephanie.Rennick@glasgow.ac.uk", "first_name"=>"Stephanie", "last_name"=>"Rennick"},
#  {"mail"=>"sandro.raess@philosophie.ch", "first_name"=>"Sandro", "last_name"=>"Räss"},
#  {"mail"=>"thomas.schindler1980@gmail.com", "first_name"=>"Thomas", "last_name"=>"Schindler"}, {"mail"=>"zoe.christoff@gmail.com", "first_name"=>"Zoé", "last_name"=>"Christoff"}]

reviewers = [
 {
   "first_name": "Joshua",
   "last_name": "Babic",
   "initials": "JB",
   "email": "joshua.babic@unige.ch"
 },
 {
   "first_name": "Agnès",
   "last_name": "Baehni",
   "initials": "AB",
   "email": "agnes.baehni@unige.ch"
 },
 {
   "first_name": "Davood",
   "last_name": "Bahjat",
   "initials": "DB",
   "email": "davoodbahjat@gmail.com"
 },
 {
   "first_name": "Philipp",
   "last_name": "Blum",
   "initials": "PB",
   "email": "philipp.blum@philosophie.ch"
 },
 {
   "first_name": "Romain ",
   "last_name": "Büchi",
   "initials": "RO",
   "email": "romain.buechi@philos.uzh.ch"
 },
 {
   "first_name": "Ralf",
   "last_name": "Busse",
   "initials": "RB",
   "email": "rbusse@uni-mainz.de"
 },
 {
   "first_name": "Claudio",
   "last_name": "Calosi",
   "initials": "CC",
   "email": "Claudio.Calosi@unige.ch"
 },
 {
   "first_name": "Sharon",
   "last_name": "Casu",
   "initials": "SC",
   "email": "sharon.casu@unifr.ch"
 },
 {
   "first_name": "Alessandro",
   "last_name": "Cecconi",
   "initials": "AC",
   "email": "alessandro.cecconi@usi.ch"
 },
 {
   "first_name": "Zoé",
   "last_name": "Christoff",
   "initials": "ZC",
   "email": "zoe.christoff@gmail.com"
 },
 {
   "first_name": "Fabrice",
   "last_name": "Correia",
   "initials": "FC",
   "email": "fabrice.correia@unige.ch"
 },
 {
   "first_name": "Louis",
   "last_name": "de Rosset",
   "initials": "LD",
   "email": "Louis.deRosset@uvm.edu "
 },
 {
   "first_name": "Catharine",
   "last_name": "Diehl",
   "initials": "CD",
   "email": "catharine.diehl@utoronto.ca"
 },
 {
   "first_name": "Julien",
   "last_name": "Dutant",
   "initials": "JD",
   "email": "julien.dutant@kcl.ac.uk"
 },
 {
   "first_name": "Philip",
   "last_name": "Ebert",
   "initials": "PH",
   "email": "philipebert@me.com"
 },
 {
   "first_name": "Matthias",
   "last_name": "Egg",
   "initials": "ME",
   "email": "matthias.egg@philo.unibe.ch"
 },
 {
   "first_name": "Patrik",
   "last_name": "Engisch",
   "initials": "PE",
   "email": "patrik.engisch@unifr.ch"
 },
 {
   "first_name": "Andrea",
   "last_name": "Giananti",
   "initials": "AG",
   "email": "andrea.giananti@unifr.ch"
 },
 {
   "first_name": "Martin",
   "last_name": "Glazier",
   "initials": "MG",
   "email": "martin.hemenway.glazier@uni-hamburg.de"
 },
 {
   "first_name": "Christoph",
   "last_name": "Haffter",
   "initials": "CH",
   "email": "christoph.haffter@unifr.ch"
 },
 {
   "first_name": "Aleks",
   "last_name": "Knoks",
   "initials": "AK",
   "email": "aleks.knoks@philos.uzh.ch"
 },
 {
   "first_name": "Simon",
   "last_name": "Kräuchi",
   "initials": "SK",
   "email": "simon.kraeuchi@phil.gess.ethz.ch"
 },
 {
   "first_name": "Nemo",
   "last_name": "Krüger",
   "initials": "NK",
   "email": "nemo.krueger@stud.unilu.ch"
 },
 {
   "first_name": "Martin",
   "last_name": "Lipman",
   "initials": "ML",
   "email": "m.a.lipman@gmail.com"
 },
 {
   "first_name": "Arturs",
   "last_name": "Logins",
   "initials": "AL",
   "email": "arturs.logins@uzh.ch"
 },
 {
   "first_name": "Jörg",
   "last_name": "Löschke",
   "initials": "JL",
   "email": "joerg.loeschke@philos.uzh.ch"
 },
 {
   "first_name": "Manolo",
   "last_name": "Martinez",
   "initials": "MM",
   "email": "mail@manolomartinez.net"
 },
 {
   "first_name": "Giovanni",
   "last_name": "Merlo",
   "initials": "GM",
   "email": "giovanni.merlo@unige.ch"
 },
 {
   "first_name": "Robert",
   "last_name": "Michels",
   "initials": "RM",
   "email": "Robert.Michels@unige.ch"
 },
 {
   "first_name": "Ryan",
   "last_name": "Miller",
   "initials": "YM",
   "email": "Ryan.Miller@etu.unige.ch"
 },
 {
   "first_name": "Jonathan",
   "last_name": "Mitchell",
   "initials": "JM",
   "email": "jonathan.mitchell@manchester.ac.uk"
 },
 {
   "first_name": "Sebastian",
   "last_name": "Muders",
   "initials": "SM",
   "email": "sebastian.muders@ethik.uzh.ch"
 },
 {
   "first_name": "Michael",
   "last_name": "Müller",
   "initials": "MI",
   "email": "mam258@cantab.ac.uk"
 },
 {
   "first_name": "Paolo",
   "last_name": "Natali",
   "initials": "PN",
   "email": "Paolo.Natali@unige.ch"
 },
 {
   "first_name": "Daniel",
   "last_name": "Nolan",
   "initials": "DN",
   "email": "dnolan2@nd.edu"
 },
 {
   "first_name": "Maria ",
   "last_name": "Nørgaard",
   "initials": "MN",
   "email": "Maria.Norgaard@unige.ch"
 },
 {
   "first_name": "Donnchadh",
   "last_name": "O'Conaill",
   "initials": "DO",
   "email": "donnchadh.oconaill@unifr.ch"
 },
 {
   "first_name": "François",
   "last_name": "Pellet",
   "initials": "FP",
   "email": "francois.pellet@uni-muenster.de"
 },
 {
   "first_name": "Christoph",
   "last_name": "Pfisterer",
   "initials": "CP",
   "email": "pfisterer@philos.uzh.ch"
 },
 {
   "first_name": "Edgar",
   "last_name": "Phillips",
   "initials": "EP",
   "email": "edgar.phillips@gmail.com"
 },
 {
   "first_name": "Jan",
   "last_name": "Plate",
   "initials": "JP",
   "email": "jan.plate@gmail.com"
 },
 {
   "first_name": "Sandro",
   "last_name": "Räss",
   "initials": "SA",
   "email": "sandro.raess@philosophie.ch"
 },
 {
   "first_name": "Stephanie",
   "last_name": "Rennick",
   "initials": "SR",
   "email": "Stephanie.Rennick@glasgow.ac.uk"
 },
 {
   "first_name": "Maria",
   "last_name": "Scarpati",
   "initials": "MA",
   "email": "maria.scarpati@unine.ch"
 },
 {
   "first_name": "Mario",
   "last_name": "Schärli",
   "initials": "MS",
   "email": "mario.schaerli@unifr.ch"
 },
 {
   "first_name": "Thomas",
   "last_name": "Schindler",
   "initials": "TS",
   "email": "thomas.schindler1980@gmail.com"
 },
 {
   "first_name": "Rafaela",
   "last_name": "Schinner",
   "initials": "RS",
   "email": "rafaela.schinner@unifr.ch"
 },
 {
   "first_name": "Sebastian",
   "last_name": "Schmidt",
   "initials": "SS",
   "email": "sebastian.schmidt@philos.uzh.ch"
 },
 {
   "first_name": "Marco",
   "last_name": "Schori",
   "initials": "MR",
   "email": "marco.schori@students.unibe.ch"
 },
 {
   "first_name": "David",
   "last_name": "Schroeren",
   "initials": "DS",
   "email": "David.Schroeren@unige.ch"
 },
 {
   "first_name": "Wolfgang",
   "last_name": "Schwarz",
   "initials": "WS",
   "email": "wolfgang.schwarz@ed.ac.uk"
 },
 {
   "first_name": "Mike",
   "last_name": "Stuart",
   "initials": "MK",
   "email": "mike.stuart.post@gmail.com"
 },
 {
   "first_name": "Fabrice",
   "last_name": "Teroni",
   "initials": "FT",
   "email": "Fabrice.Teroni@unige.ch"
 },
 {
   "first_name": "Giuliano",
   "last_name": "Torrengo",
   "initials": "GT",
   "email": "giuliano.torrengo@gmail.com"
 },
 {
   "first_name": "Marco",
   "last_name": "Toscano",
   "initials": "MT",
   "email": "marco.toscano@uzh.ch"
 },
 {
   "first_name": "Daniel",
   "last_name": "Vanello",
   "initials": "DV",
   "email": "D.Vanello.1@warwick.ac.uk"
 },
 {
   "first_name": "Lisa",
   "last_name": "Vogt",
   "initials": "LV",
   "email": "lisa.vogt@yahoo.de"
 },
 {
   "first_name": "Jonas",
   "last_name": "Waechter",
   "initials": "JS",
   "email": "jonaswaechter@yahoo.com"
 },
 {
   "first_name": "Christian",
   "last_name": "Weibel",
   "initials": "CW",
   "email": "weibel@philos.uzh.ch"
 },
 {
   "first_name": "Jonas",
   "last_name": "Werner",
   "initials": "JW",
   "email": "jonas.werner@philo.unibe.ch"
 },
 {
   "first_name": "Nathan",
   "last_name": "Wildman",
   "initials": "NW",
   "email": "N.W.Wildman@tilburguniversity.edu"
 }
]

reviewers.each do |reviewer|
  #puts ("#{reviewer["first_name"].downcase}.#{reviewer["last_name"].downcase}").parameterize
  #acronym = reviewer.first.split(/ |-/).map(&:first).join.downcase

  unless reviewer.blank?
    new_user = User.create(username: reviewer[:initials].downcase, email: reviewer[:email].downcase, password: "epikur", password_confirmation: "epikur", firstname: reviewer[:first_name], lastname: reviewer[:last_name])
    new_user.roles << Role.find_by_name("reviewer")
    new_user.roles << Role.find_by_name("author")
  end

  #puts new_user.save!
end

admin = User.create(username: "admin", email: "admin@gmail.com", password: "epikur", password_confirmation: "epikur", firstname: "Admin", lastname: "Admin")
admin.roles << Role.find_by_name("admin")
admin.roles << Role.find_by_name("editor")
admin.roles << Role.find_by_name("reviewer")
admin.roles << Role.find_by_name("author")

editor = User.create(username: "editor", email: "editor@gmail.com", password: "epikur", password_confirmation: "epikur", firstname: "Editor", lastname: "Editor")
editor.roles << Role.find_by_name("editor")
editor.roles << Role.find_by_name("reviewer")
editor.roles << Role.find_by_name("author")

reviewer = User.create(username: "reviewer", email: "reviewer@gmail.com", password: "epikur", password_confirmation: "epikur", firstname: "Reviewer", lastname: "Reviewer")
reviewer.roles << Role.find_by_name("reviewer")
reviewer.roles << Role.find_by_name("author")

author = User.create(username: "author", email: "author@gmail.com", password: "epikur", password_confirmation: "epikur", firstname: "Author", lastname: "Author")
author.roles << Role.find_by_name("author")

anonymous_user = User.create(username: "anonymous_user", email: "anonymous_user@gmail.com", password: "epikur", password_confirmation: "epikur", firstname: "Anonymous", lastname: "User")
anonymous_user.roles << Role.find_by_name("author")


#fresh_submissions = [{"id"=>"4005", "created_at"=>"20.12.2019", "dead"=>"false", "pdf_name"=>"4005.pdf", "email"=>"iskra.fileva@gmail.com", "name"=>"Iskra Fileva", "other_authors"=>"Linda Brakel", "country"=>"US", "title"=>"A New View of Self-Constitution", nil=>nil, "status"=>"internal refereeing", "reviewer1"=>"Donnchadh", "reviewer2"=>"Daniel", "reviewer3"=>"Giovanni", "gender"=>"female", "comment"=>" I think you can publish this.\n\nIt's well put together and seems to do a good job with the literature, and if it's right, some major views are problematic .\n\nOn the major views, a suggestion: the whirlwind tour of names and views gets a bit dizzying, and this may deprive the paper of some rhetorical punch. The initial target is Plantonic-Kantian, \"pruners,\" like Korsgaard, Velleman and Franfurt, and while I defer to people more steeped in the literature, I see a unity here. But toward the conclusion of the paper, when much of the heavy lifting has been done, we get other, pretty different targets, like Sripada and Buss, instead of a definitive deal closing on the initial targets. I wonder if more tightly focused targeting might make the paper more effective, esp. since the later sections might strike people sympathetic to those targets as a little breezy.\n\nAlso, the paper relies heavily on a psychoanalytic perspective, and I'd like to see a bit more on the empirical credentials of this approach. Outcome studies? Validations of central theoretical posits?\n\nFor example, the authors quote this with approval:\n\n\"She was obviously caught in a trauma system.\"\n\nObvious? I'm not even sure what it means. After figuring that out, I'd like to see evidence that trauma systems are an evidence backed lens on anger and marital discord.\n\nFootnote 28 suggests an alternative: maybe psychoanalysis is not necessary to the argument, but stands as an illustration of a general approach. The evidential standards for this heuristic use might be lower.\n\nIn any event, more self consciousness about the difficulty with psychoanalysis, and the role it plays here would be very welcome.\n\nI'd like to see these items addressed, but in any event, a worthwhile piece, and better than much of what I get sent to review.\n\n", "mail"=>nil, "firstname"=>"Iskra", "lastname"=>"Fileva"}, {"id"=>"4058", "created_at"=>"13.5.2020", "dead"=>"false", "pdf_name"=>"4058.pdf", "email"=>"Maarten.VanDyck@UGent.be", "name"=>"Wim Vanrie", "other_authors"=>"Maarten van Dyck", "country"=>"Belgium", "title"=>"Boghossian, Bellarmine and Galileo: historical evidence for epistemic relativism", nil=>nil, "status"=>"internal refereeing", "reviewer1"=>"Matthias", "reviewer2"=>nil, "reviewer3"=>nil, "gender"=>"male", "comment"=>"Markus Seidel: I have read it. It’s intelligent and well-written. But it’s not especially well-organized and it's not always clear exactly what the authors want their central claims to be. They have a lot of irons in the fire. Some of it is about the importance of actual cases; but the role they find for that is mostly heuristic, rather than probative. At other times, the claim seems to be that G and B agree about the fundamental principles of the epistemic system to use, but disagree about whether they apply in a given case. That’s not quite a defense of relativism. Sometimes the claim is that they are perfectly OK being what I call ‘absolutist relativists,’ which does not involve a denial of the existence of absolute epistemic facts. \n\nI lean towards thinking it should be published but the paper would be a lot better if they stated clearly and up front which central claims they want to defend and why.", "mail"=>nil, "firstname"=>"Wim", "lastname"=>"Vanrie"}, {"id"=>"4061", "created_at"=>"23.4.2020", "dead"=>"false", "pdf_name"=>"4061.pdf", "email"=>"sarnaud@gc.cuny.edu", "name"=>"Sarah Arnaud", "other_authors"=>"Kathryn Pendoley", "country"=>"US", "title"=>"Internal Intentionalism and the understanding of emotion experience", nil=>nil, "status"=>"internal refereeing", "reviewer1"=>"Fabrice T.", "reviewer2"=>nil, "reviewer3"=>nil, "gender"=>"female", "comment"=>"Jonathan Mitchell: The paper purports to develop a plausible version of strong intentionalism for emotions (SIe) the author calls ‘internal’ intentionalism (ii). According to the author, (ii) differs from other possible versions of (SIe) in that on (ii) we represent formal objects (viz. evaluative properties) in a way that is specific – e.g., this particular emotional situation is dangerous for-me-now – and indexed to the emoter, that is, “significantly dependent on the emoter’s identity” (p 12) – i.e., on her life, standing concerns, current interests, etc\n\nThe proposed conception of the way formal objects are represented in emotion is not original. Although the specificity and subject-dependence of formal objects are worth emphasising, both claims would arguably be accepted by most theorists working on emotion – no one, to my knowledge, argues that formal objects are represented as unattached, or “on their own”, alongside the material objects of the emotion (pp. 11-12), and the idea that emotional evaluations are partially dependent on the emoter is also widely accepted (Cf. e.g., Roberts’ (2005) account of emotions as concern-based ‘construals’; Frijda’s (1986; 2007) influential concept of ‘concern-relevance’, Deonna&Teroni’s (2012, ch. 8) on the emoters’ contribution to the supervenience bases of evaluative properties). On the other hand, (ii), pace the author, doesn’t address the main challenge faced by SIe, that is, how to account for the fact that during emotions we are intentionally related to formal objects without thereby implying that emotions are directed towards formal objects – e.g., that we are afraid of the dangerousness of the bear (see Mulligan (2007); Deonna & Teroni (2012)). Saying that the formal objects are attached to the material objects and not represented on their own will not suffice and the author doesn’t sufficiently clarify how it could. Finally, the paper has structural/dialectical problems which make the argumentation difficult to follow. In particular, the dialectic of the paper opposes SIe to accounts of emotional content appealing to irreducible phenomenal properties as if these were the only options. It seems the discussion should include attempts to locate the emoters’ relation to formal objects at the level of the attitude vs the content – such as Crane (2001), Deonna & Teroni (2012) and subsequent elaborations – or else clarify that the scope of the paper is more restricted and what the rationale for this restriction is.\n\nFor all of the above reasons, I recommend rejection.\n\n\n\n", "mail"=>nil, "firstname"=>"Sarah", "lastname"=>"Arnaud"}, {"id"=>"4080", "created_at"=>"24.6.2020", "dead"=>"false", "pdf_name"=>"4080.pdf", "email"=>"jon.perez@ehu.eus", "name"=>"Jon Laraudogoitia ", "other_authors"=>nil, "country"=>"Spain", "title"=>"A New Contact Paradox", nil=>nil, "status"=>"internal refereeing", "reviewer1"=>"Matthias", "reviewer2"=>"Claudio", "reviewer3"=>nil, "gender"=>"male", "comment"=>nil, "mail"=>nil, "firstname"=>"Jon", "lastname"=>"Laraudogoitia"}, {"id"=>"4096", "created_at"=>"3.8.2020", "dead"=>"false", "pdf_name"=>"4096.pdf", "email"=>"katharina.felka@uni-graz.at", "name"=>"Katharina Felka", "other_authors"=>nil, "country"=>"Austria", "title"=>"Focus effects in number sentences revisited", nil=>nil, "status"=>"at refereeing stage", "reviewer1"=>"Catharine", "reviewer2"=>nil, "reviewer3"=>nil, "gender"=>"female", "comment"=>"Robert Schwartzkopff: This paper is a well-informed, on top of the literature, reply to an argument by Barlew concerning the semantics of certain sentences which are of significance in metaphysics and the philosophy of arithmetic. The paper is short and on point, and mostly plausible. The immediate response to the authors discussion to Barlew’s argument, which occurred to me while reading it and surely will occur to many others, is briefly addressed only in a short footnote 9: it seems inessential that implication is understood as a relation among sentences in Barlew’s formulation of the argument, and similar examples with “broad” or sentential focus could be given where it isn’t the case that a sentence is requested as an answer, but rather some fact is requested, articulated with a sentence. The author briefly discusses one such option, but I suspect many more can be given where the author’s reply wouldn’t work. I feel the force of the author’s point would certainly be improved if this issue could be discussed a bit more generally, and not just in a footnote and with one example. There are all kinds of constructions that can lead to broad focus, and I am just picking off the top of my hat here: \"Tell me something interesting/boring related to Mars having two moons.” Would the author’s reply suggested in footnote 9 still work for this? If so, and if that can be argued for in some generality, that would make the paper stronger than it is now, strong as it might be already. ", "mail"=>nil, "firstname"=>"Katharina", "lastname"=>"Felka"}, {"id"=>"4109", "created_at"=>"20.8.2020", "dead"=>"false", "pdf_name"=>"4109.pdf", "email"=>"jean.moritz.mueller@gmail.com", "name"=>"Moritz Müller", "other_authors"=>nil, "country"=>"Germany", "title"=>"In Defense of the Content-Priority View of Emotion", nil=>nil, "status"=>"at refereeing stage", "reviewer1"=>"Fabrice T", "reviewer2"=>"Edgar", "reviewer3"=>nil, "gender"=>"male", "comment"=>nil, "mail"=>nil, "firstname"=>"Moritz", "lastname"=>"Müller"}, {"id"=>"4112", "created_at"=>"19.8.2020", "dead"=>"false", "pdf_name"=>"4112.pdf", "email"=>"libermana@uindy.edu", "name"=>"Alida Liberman", "other_authors"=>nil, "country"=>"US", "title"=>"The Mental States First Theory of Promising", nil=>nil, "status"=>"internal refereeing", "reviewer1"=>"Fabrice T", "reviewer2"=>"Patrik", "reviewer3"=>"Philipp B.", "gender"=>"female", "comment"=>nil, "mail"=>nil, "firstname"=>"Alida", "lastname"=>"Liberman"}, {"id"=>"4120", "created_at"=>"3.9.2020", "dead"=>"true", "pdf_name"=>"4120.pdf", "email"=>"s1772889@sms.ed.ac.uk", "name"=>"Olivia Coombes", "other_authors"=>nil, "country"=>"UK", "title"=>"Time Travel and Ability", nil=>nil, "status"=>"done", "reviewer1"=>"Steph", "reviewer2"=>nil, "reviewer3"=>nil, "gender"=>"female ", "comment"=>"Quick turn around time for this one. It was interesting! But way underdeveloped. I recommend rejection. Report below, for both author and editor.\n\nReferee Report on Time Travel & Ability\nThis paper argues that time travellers may have the ability to change the past even if the probability of them doing it is zero. The author argues that their own theory of ability allows them to say this.\nIt’s an interesting paper. Ultimately, the ideas might well be publishable. Having read it I am intrigued and would like to know a lot more about the author’s new theory of ability. But at the moment it is too undeveloped and the more developed version of this paper will be so different from the current paper that I recommend rejection.\nMy main issue with the paper is that the author’s theory of ability is not adequately explained in enough depth. They talk about ‘inputs’ and ‘outputs’ but never really get clear on what they are. For instance, input and outputs are generally associated with functions. So are abilities functions? (It might not be a problem if they are, but the author needs to explicitly flag these things up.) Equally, what *are* the inputs and outputs? By which I mean, what ontological category are they meant to be? At some point the author talks about ‘inputs’ as if inputs are worlds, or sets of worlds. See page 5: ‘her winning occurs are infinitely many nomologically accessible worlds. It is these inputs…’. Elsewhere, inputs are not talked about in these terms. This needs to be clarified. Finally, two or three worked examples (of simple, straightforward cases with no difficult issues involved) would help make clear what was going on. \nAs I said above, I am interested in the theory. But since I do not really understand what inputs and outputs are, I cannot follow what the theory of ability is. (Further, when on page 6 two types of ‘input conditions’ are introduced, this confuses me because I am not sure what the difference between the two are. Also, are ‘inputs’ different from ‘input conditions’?)\nIn a future iteration of this paper I would suggest the exposition of the theory occupying a substantial part of the paper, such as a few thousand words. As it is, the current exposition races through without enough explanation.\nI also have two worries with the material on Lewis and Vihvelin.\nWith Lewis, the author says that Lewis’s position is that having the ability to X does not imply the possibility that one will succeed in X-ing (page 2). That’s false. In the time travel case, Lewis agrees that there’s a context in which Tim can shoot his grandfather. In that context there *are* worlds at which Tim succeeds (and it *is* possible for Tim to succeed). However, those worlds are worlds where he shoots the wrong man or his grandfather comes back from the dead. Whilst there are contexts where those worlds are not close enough to be relevant, Lewis would say that in *those* contexts, Tim *cannot* shoot his grandfather. Lewis does not say there’s a context in which both (i) Tim has the ability to shoot the man over there and (ii) there is no possibility of Tim succeeding in shooting the man over there. Lewis’s theory of ability explicitly rules that out.\nWith the material on Vihvelin, there is a conflation of issues to do with ‘might’ and issues to do with probability. Vihvelin only talks about what might happen, but in section 2 the author shifts to talking about probability. These are two different things. Crucially, as the author notes in footnote 3, there are cases where something might happen even though it has a probability of zero. So when the author later writes (page 6) ‘for Vihvelin due to CA* a time traveller is only able to kill their grandfather if there is a chance of the time traveller succeeding’, that’s false. Vihvelin endorses CA*, but CA* only says that if someone has the ability to X then they might X. CA* makes no mention of probability. The author appears to implicitly assume that if something has a probability of zero then it is not the case that it might happen. But, as the infinite lottery case makes clear, that’s not true. Something *can* have a probability of zero whilst it is still the case that it might happen. So CA* does not imply anything about the connection between ability and probability. \nOne, last, minor point. On page 1 the author talks about the Grandfather Paradox ‘necessitating’. If the Paradox is an argument, not a proposition, then it cannot necessitate anything. A pedantic point, but worth noting. \n", "mail"=>nil, "firstname"=>"Olivia", "lastname"=>"Coombes"}, {"id"=>"4123", "created_at"=>"8.9.2020", "dead"=>"true", "pdf_name"=>"4123.pdf", "email"=>"timperrine@gmail.com", "name"=>"Timothy Perrine", "other_authors"=>nil, "country"=>"US", "title"=>"Realism, Naturalism, and Hazlett’s Challenge concerning Epistemic Value", nil=>nil, "status"=>"done", "reviewer1"=>"Jan", "reviewer2"=>"Fabrice C", "reviewer3"=>nil, "gender"=>"male", "comment"=>" Thanks for sending me the new version. I have now looked at the new version of the paper and I can recommend it for publication in dialectica.\n", "mail"=>nil, "firstname"=>"Timothy", "lastname"=>"Perrine"}, {"id"=>"4132", "created_at"=>"25.9.2020", "dead"=>"true", "pdf_name"=>"4132.pdf", "email"=>"philosophy@kirklougheed.com", "name"=>"Kirk Lougheed", "other_authors"=>nil, "country"=>"South Africa", "title"=>"Molefe on the Value of Community for Personhood", nil=>nil, "status"=>"done", "reviewer1"=>"Jörg", "reviewer2"=>nil, "reviewer3"=>nil, "gender"=>"male", "comment"=>nil, "mail"=>nil, "firstname"=>"Kirk", "lastname"=>"Lougheed"}]


fresh_submissions = []

fresh_submissions.each do |submission|
  #sub = Submission.create(title: submission[:title], id: submission[:id], created_at: Date.parse(submission[:date]))

   #sub = Submission.create(submission)
  cleared_hash = submission.reject{|k,v| !Submission.column_names.member?(k.to_s) }
  sub = Submission.create(cleared_hash)
  #byebug
  #sub.file.attach(io: File.open("#{Rails.root}/public/submissions/#{submission[:pdf_name]}"), filename: submission[:pdf_name])
  sub.file.attach(io: File.open("#{Rails.root}/public/submissions/#{submission["pdf_name"]}"), filename: submission["pdf_name"])
end

#byebug
#4005
#User.find_by_email("donnchadh.oconaill@unifr.ch").submissions << Submission.find(4005)
#User.find_by_email("d.vanello.1@warwick.ac.uk").submissions << Submission.find(4005)
#User.find_by_email("giova_merlo@yahoo.it").submissions << Submission.find(4005)

#4058
#User.find_by_email("matthias.egg@philo.unibe.ch").submissions << Submission.find(4058)

#4061
#User.find_by_email("fabrice.teroni@unige.ch").submissions << Submission.find(4061)

#4080
#User.find_by_email("matthias.egg@philo.unibe.ch").submissions << Submission.find(4080)
#User.find_by_email("claudio.calosi@unige.ch").submissions << Submission.find(4080)

#4096
#User.find_by_email("catharine.diehl@utoronto.ca").submissions << Submission.find(4096)

#4109
#User.find_by_email("fabrice.teroni@unige.ch").submissions << Submission.find(4109)
#User.find_by_email("edgar.phillips@gmail.com").submissions << Submission.find(4109)

#4112
#User.find_by_email("patrik.engisch@unifr.ch").submissions << Submission.find(4112)
#User.find_by_email("philipp.blum@philosophie.ch").submissions << Submission.find(4112)
#User.find_by_email("d.vanello.1@warwick.ac.uk").submissions << Submission.find(4112)

#4120
#User.find_by_email("stephanie.rennick@glasgow.ac.uk").submissions << Submission.find(4120)

#4123
#User.find_by_email("jan.plate@gmail.com").submissions << Submission.find(4123)
#User.find_by_email("fabrice.correia@unige.ch").submissions << Submission.find(4123)

#4132
#User.find_by_email("joerg.loeschke@philos.uzh.ch").submissions << Submission.find(4132)

#histories
#Submission.all.each do |submission|
#  unless submission.comment.blank?
#    History.create(user_id: User.find_by_email("admin@mail.com").id, submission_id: submission.id, content: submission.comment)
#  end
#end

#pages
#Page.create(title: "bibliography", description: "bibliography") unless Page.find_by_slug("bibliography").present?
#Page.create(title: "journals", description: "journals") unless Page.find_by_slug("journals").present?
#Page.create(title: "books", description: "books") unless Page.find_by_slug("books").present?

#@message.image.attach(io: File.open('/path/to/file'), filename: 'file.pdf', content_type: 'application/pdf')
