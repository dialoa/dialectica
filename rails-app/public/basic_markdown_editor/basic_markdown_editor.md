---
doi: 10.48106/dial.v74.i2.01
title: 'The Formalization of Arguments'
subtitle: 'An Overview'
author: 
- name: Robert Michels
  email: mail@robert-michels.de
  correspondence: true
  institute:
  - Università della Svizzera italiana
  - University of Bern
bibliography: michels_bib.bib
abstract: |
 The purpose of this introduction is to give a rough overview of the
 discussion of the formalization of arguments, focusing on deductive
 arguments. The discussion is structured around four important
 junctions: i) the notion of *support*, which captures the relation
 between the conclusion and premises of an argument, ii) the choice of
 a *formal language* into which the argument is translated in order to
 make it amenable to evaluation via formal methods, iii) the question
 of *quality criteria* for such formalizations, and finally iv) the
 *choice of the underlying logic*. This introductory discussion is
 supplemented by a brief description of the genesis of the special
 issue, acknowledgements, and summaries of each article.
nocite: |
 @tarski_a:1936a, @tarski_a:1936e, @congres:1936f
editor_options: 
 markdown: 
 wrap: 72
---

# The Formalization of Arguments

An argument in the philosophical sense is a set of sentences consisting
of (at least)[^1] one sentence stating a conclusion and (at least) one
sentence stating a premise which is or are supposed to support the
conclusion.[^2] Arguments are of central importance to philosophy not
only as a subject of systematic study, but also methodologically as the
means to criticise or support philosophical claims and theories. More
generally, arguments are an indispensable part of any responsible
rational discourse; to give an argument for a claim is to give a reason
for it and to set out this reason for oneself and for others to
scrutinize.

[^1]: Most arguments discussed by philosophers involve only one
 conclusion and some have argued against admitting multiple
 conclusions [see e.g. @steinberger_f:2011a], but there are systematic
 developments of multiple conclusion logics. See e.g.
 @shoesmith-smiley:1978. For the sake of simplicity, I will focus on
 single conclusion arguments throughout most of this text.

[^2]: Note that throughout this paper I will mostly refer to natural
 language sentences instead of e.g. utterances of them. I will ignore
 related metaphysical questions including e.g. questions about what
 sentences are or about propositions and their relation to natural
 language sentences and sentences of formal languages. The focus on
 sentences is both in line with at least significant parts of the
 literature on formalization and moreover also serves to simplify and
 homogenize the discussion of different views. I hope that the
 presentational advantages outweigh the costs of imprecision and a
 sometimes dangerously liberal use of the term "sentence."

The analysis, development, and critique of arguments are some of the
most important tasks performed by contemporary philosophers working in
the analytic tradition. The process of formalization is an important
step in any one of these tasks since it makes arguments amenable to the
application of formal methods, such as those of model theory or of proof
theory. These methods give us precise and objective quality-criteria for
arguments, including in particular criteria for their logical validity.

Assuming that we have identified the premises and conclusion of an
argument, its formalization will require us to make a number of choices,
including those captured by the following four interrelated questions:

1. Which kind of inferential support do the premises lend to the
 conclusion of the argument?
2. Into which formal language should we translate the argument's premises
 and conclusion?
3. What makes such a translation into a particular formal language
 adequate?
4. Which formalisms can be used to evaluate the quality of the
 argument?

The remainder of this introduction is structured around these four
questions about the formalization of arguments. It starts out with a
brief discussion of each of these questions in the following four
sections, briefly discussing some answers given in the literature and
providing some references for further reading. The main aim of this
introductory part of this paper is to give readers who are not familiar
with the relevant literature a partial look at the more general
discussion to which the papers collected in this special issue
contribute. This overview is neither comprehensive, nor authoritative.
The last two sections of the introduction contain some information about
the genesis of the special issue and the editor's acknowledgements and a
brief overview of the content of the papers published in this special
issue.

# Inferential Support

A standard classification of arguments individuates kinds of arguments
in terms of the kind of *inferential support* which its premises lend to
an argument's conclusion. We may accordingly distinguish between, among
others, abductive, statistical, inductive, deductive arguments and
arguments from analogy. The sort of arguments we encounter in everyday
life, e.g. in discussions with neighbours and friends or in political
debates, rarely fit into just one of these categories. Rather, they
might consist, for example, of an abductive argument for a conclusion
which in turn serves as a premise among others in a deductive argument,
whose conclusion in turn is used to argue for another claim by analogy,
and so on. They may of course also involve particular forms of reasoning
which do not neatly fit into the classificatory scheme which one finds
in philosophy books, e.g. because they draw on particular non-verbal
aspects of a particular discussion, or positively contribute to a debate
in a particular context, even though they have the form of a logical
fallacy (e.g. an appeal to authority). One might hence argue that
theoretical engagement with "real world" arguments require different,
perhaps more permissive approaches than those covered in introductory
books and courses on logic and critical thinking.[^3] Still, many such
arguments, or at least parts of them, can be broken down into smaller
segments which exemplify one of the canonical argument types.

[^3]: See e.g. @betz_g:2010[@betz_g:2013]. See also 
 @groarke_le:2017 for an overview of the field of informal
 logic.

Deductive arguments enjoy a special status in philosophy due to the
particularly strict way in which the premises of a deductive argument
supports its conclusion. Consider for example the following argument:

(@one) If the train runs late, its passengers will miss their connections.

(@two) The train runs late.

(@three) $\therefore$ Its passengers will miss their connections.

The conclusion of this argument, which in schemas of this sort will be
marked by the prefixed symbol "$\therefore$" throughout this text, like
that of any valid deductive argument, is logically entailed by its
premisses. But what is logical entailment? In contemporary logic, there
are two fundamental accounts of what it means for a sentence to be
logically entailed by another. The first is the syntactic account which
characterizes logical entailment proof-theoretically in terms of
derivability or provability in a logical system. Considering the formal
language of first-order logic, the core idea of this account is that a
sentence $s$ of language is logically entailed by a set of sentences
$\Delta$ of the same language if, and only if, there is a proof of $s$
which can be constructed in a formal calculus, e.g. using the
introduction- and elimination-rules of the logical constants in case of
the natural deduction calculus, and taking at most the sentences in
$\Delta$ as hypotheses.[^4] The second account is the semantic account,
which characterizes entailment in model-theoretic terms. Its core idea
is that, focusing again on the language of first order logic, a sentence
$s$ (i.e. a well-formed formula of that formal language) is logically
entailed by a set of sentences $\Delta$ if, and only if, for all models
$\mathfrak{M}$ for this language, if all sentences in $\Delta$ are true
in $\mathfrak{M}$, $s$ is true in $\mathfrak{M}$, where a model is a
set-theoretical construction used to semantically interpret all
well-formed sentences of the language.[^5] As is well-known, the two
relations characterized by these accounts coincide for sound and
complete logics, such as classical first-order logic, in the sense that
they render exactly the same entailments valid. The term "logical
consequence" is usually reserved for the latter, semantic notion and I
will follow this convention in the remainder of this section.

[^4]: The two standard systems in the contemporary discussion (natural
 deduction and the sequent calculus) were introduced in @gentzen:1935; see @vonplato_j:2008a;@schroederheister:2018 for more general introductions to
 proof-theory.

[^5]: The key historical text is @tarski_a:2002; see @beall-etal:2019
 for an introduction.

It is important to distinguish the question of the validity of an
argument from that of its *soundness*. An argument is sound if, and only
if, it is both valid, i.e. if its conclusion is logically entailed by its premises, and if its premises are true. Neither the proof-theoretic,
nor the model-theoretic approach just described is concerned with the
truth of an argument's premises. Both approaches target the notion of
validity.

The proof-theoretic characterization of deductive entailment is
intrinsically linked to particular formal systems which characterize
logical expressions like that of negation, conjunction, or the
quantifiers in terms of introduction- and elimination-rules which tell
us under which conditions we can either introduce or eliminate formulas
containing such an expression in the context of a proof. The totality of
these rules fix what is provable in such a system and a fortiori give us
the sort of syntactic characterization of logical entailment which
interests us in the current context. One important philosophical
question about introduction- and elimination-rules in a formal system
concerns the relation between the two kinds of rules. It was forcefully
raised in @prior_an:1960, who argued against the idea that the meaning of
logical expressions is completely fixed by their introduction- and
elimination-rules by introducing the connective "tonk" whose associated
pair of rules permit us to derive absolutely any sentence from any
sentence. An influential idea for how the problem raised by "tonk" and
similarly problematic connectives can be avoided is that such
connectives violate a harmony-constraint which is supposed to govern the
relation between a logical expression's introduction- and its
elimination-rules.[^6] But even if it turned out that such a constraint
can be formulated, Prior's argument could still be taken to show that,
as Prawitz puts it, "ordinary proof theory has nothing to offer an
analysis of logical consequence" [-@prawitz:2005, 683].[^7] A suitable
notion of harmony may give us a way of guarding a formal system against
incoherence and a fortiori allow us to accept its harmonious
introduction- and elimination-rules as constitutive of the meaning of
its logical expressions within that system. Even so, there still would
remain an explanatory gap between a formal-system-relative harmonious
notion of provability and the general, formal-system-independent notion
of logical consequence. One proposal for a way to close this gap is due
to Dummett and Prawitz, who argue that logical consequence can be
characterized using proof-theoretic means and the notion of canonical
proof [see e.g. @dummett_mae:1976; @prawitz:1974; @prawitz:2005].

[^6]: See e.g. @dummett_mae:1991a[ch. 9], and @tennant_nw:1987, @steinberger_f:2011a, and for a recent criticism, @rumfitt:2017a.

[^7]: This quote echoes the approach taken by @tarski_a:1956g[412f], and followed by
 many contributors to the recent literature, who motivates his
 semantic definition of logical consequence by arguing against the
 syntactic approach. 

Concerning the semantic characterization, many contributors to the
recent literature have focused on two different properties which might
be used to characterize or define logical consequence, that of being
*necessarily truth-preserving* and that of being *formal*.

That logical consequence is closely linked to necessity is a
well-established idea in analytic philosophy.[^8] In the contemporary
debate, this connection is usually spelled out in terms of necessary
truth-preservation: If a sentence $s$ is a logical consequence of a set
of sentences $\Gamma$, then it is necessary that if the sentences in
$\Gamma$ are true, so is $s$. Or, to put it differently, it is
impossible for the sentences in $\Gamma$ to be true, but for $s$ not to be.

[^8]: See e.g. Wittgenstein's claim that deductive inferences have an
 inner necessity in §5.1362 of his *Tractatus* [-@wittgenstein:1922].

The property of being necessarily truth preserving distinguishes
deductive from inductive arguments, such as the following:

(@four) Every dog which has been observed up until now likes to chase cats.

(@five) Bella is a dog.

(@six) $\therefore$ Bella is a dog who likes to chase cats.

Clearly, the fact that every dog observed up until now likes to chase
cats does not guarantee that absolutely every dog, including (possibly
unobserved) Bella, likes to chase cats. The truth of the premises of
this argument, and of those of any inductive argument in general, does
not necessitate the truth of its conclusion.[^9] The focus of this
special issue and of the following parts of this introduction is on
deductive arguments.

[^9]: Since both arguments by analogy and statistical arguments can be
 considered special kinds of inductive arguments [see @salmon_wc:1963,
 ch. 3], the same holds for them. Abductive arguments also fail to be
 necessarily truth-preserving, but it can be argued that abduction is
 not just a special case of induction [see @douven:2017b].

While necessary truth preservation plausibly gives us a necessary
condition for an argument's being deductive, i.e. for its conclusion to
be a logical consequence of its premises, there are reasons to doubt
that the notion of logical consequence can be adequately explained,
characterized, or defined in terms of this property. An important open
question in this regard is what kind of necessity the property of
necessarily preserving truth involves. The seemingly obvious claim that
it is the notion of logical necessity would lead us into an explanatory
circle, since logical necessity is plausibly explainable in terms of
logical consequence. It is furthermore not clear whether other kinds of
necessity, such as for example analyticity, a priority, or metaphysical
necessity, can serve this purpose [see @beall-etal:2019, section 1].

The second property which is much discussed in the literature on logical
consequence is the notion's *formality*. Intuitively speaking, this
property distinguishes logical inferences from material entailments such
as:

(@seven) The ball is red.

(@eight) $\therefore$ The ball is coloured.

Or:

(@nine) Some dog sees some cat.

(@ten) $\therefore$ Some cat is seen by some dog.

While these arguments reflect intuitively correct inferences, their
conclusions are not logical consequences of their premises. This is
because the entailments from (@seven) to (@eight) and from (@nine) to (@ten) obtain due
to the material content of these sentences, i.e. due to what the
sentences are about, not due to their form: That (@eight) is entailed by (@seven) is guaranteed by the meanings of "is red" and of "is coloured" and that (@ten) is entailed by (@nine) is guaranteed by the meanings of "sees" and "is seen by."

The validity of a deductive argument in contrast depends solely on the
logical form of its premises and conclusion.[^10] The logical form of a
sentence in turn is determined by the logical expressions it contains
and the way they combine with the contained non-logical expressions.
That deductive logic is formal in this sense is uncontroversial, but it
is hard to say what "formal" means without just defining it ostensively
by referring to examples of sentences which we assume to share the same
logical form. Can we define the notion of formality in other terms,
giving us a systematic criterion to distinguish between the logical and
the non-logical expressions of a language? There are several answers to
this question two of which will now be briefly introduced.[^11] Before
this is done, it should be noted that while the focus in the current
section is on the notion of logical consequence, most of the discussion
of formality focuses on the use of this notion to distinguish logical
from non-logical expressions of languages.[^12] There is a direct
connection between these two loci of formality, since the logical
expressions in a sentence determine its logical form and it is in turn
the logical form of sentences which ensure that they stand in the
relation of logical consequence.[^13]

[^10]: While this clearly holds for the notion of validity one gets e.g.
 from classical first-order logic, one might see relevance (also:
 *relevant*) logic as an exception. The core idea of relevance logic
 is that certain intuitively paradoxical inferences, which are valid
 in classical logic, can be ruled out as invalid by imposing a
 relevance constraint to the effect that the conclusion of an
 argument (or the consequent of a conditional) should not be on a
 different topic than its premises (the conditional's antecedent).
 This constraint is however implemented via a formal principle. See
 @mares:2012a for an overview.

[^11]: For discussions of further answers, see e.g. @macfarlane_j:2000, @dutilhnovaes:2011.

[^12]: See e.g. @tarski_a:1986, @sher_gy:1991, @bonnay:2008.

[^13]: See, however, @sagi_gi:2014 for an alternative view.

One approach to formality proposed in the literature says that formality
can be understood in terms of topic neutrality [see e.g. @ryle:1954, 115ff; @haack_s:1978, 5--6]. The idea is that
logical entailments hold irrespective of what the entailed and the
entailing sentences are about. What distinguishes the logical
expressions of a language is that they, unlike predicates like "is red"
and "is coloured" or individual constants, are not about any thing in
particular, but that their meaning is rather tied to certain schematic
patterns of application which are universally applicable. This criterion
for formality gives us a simple and plausible explanation of why the
entailment from (@seven) to (@eight) is not formal and thus not logical. The main
problem noted even by those like Haack who are sympathetic to it is that
topic neutrality only gives us a vague criterion for demarcating logical
from non-logical expressions: Why could we for example not count the
inference from (@nine) to (@ten) as formal? After all, it might appear that we can
extract a schematic pattern of the following form from this entailment:

(@eleven) $x$ $\Phi$s $y$.

(@twelve) $\therefore$ $y$ is $\Phi$ed by $x$.

Putting complications about surface grammar aside which the schema
ignores (e.g. "sees" and "is se*en* by"), one may on the one hand
argue against its formality by pointing out that the correctness of the
inference seems to depend on the seemingly material fact that "$\Phi$s"
and "is $\Phi$ed by" are converse relations. On the other hand, one
might argue that the two converses are really identical [see @williamson_t:1985] and then claim that (@eleven) and (@twelve) are just the same
sentence in different guises. After stripping away these guises, the
inference would really just be a trivial inference from one sentence to
itself, instantiating an inference schema which holds irrespective of
what the sentence involved means. The point here is of course only that
as a criterion for logicality, topic neutrality leaves room for
disagreement about particular cases, giving us at best a vague account
of what formality is.

The second account of formality is provided by Tarski's classical
permutation-invariance-based characterization of logicality [see -@tarski_a:1986]. This account could be seen as a way to make the
topic-neutrality-based account of formality more precise. Its core idea
is that the distinguishing feature of logical expressions is that their
meaning is invariant under all permutations of the domain of objects of
a model. A *model* in the model-theoretic sense is a set-theoretical
construction based on a domain of objects which is designed to enable us
to semantically interpret sentences of a formal language in
set-theoretic terms with respect to that domain. A *permutation of the
domain of a model* is a function which maps each object in that domain
to a unique object from the same domain. Within a model, first-order
predicates can e.g. be interpreted as sets of objects and first-order
relational predicates accordingly as sets of tuples of objects. Logical
expressions are also given a set-theoretic interpretation, so that
first-order quantifiers can e.g. be interpreted in terms of relations
between predicates, i.e. sets of tuples of sets of objects. The sets
corresponding to material predicates in a model, such as e.g. the
relational predicate "is larger than" in a model which is used to
interpret a fragment of natural language involving the predicate, vary
under at least some permutations of a model's domain. There will e.g. be
a permutation which maps two objects *a* and *b* which stand in this
relation to other objects from the domain which do not (e.g. simply to
*b* and *a*, respectively). The idea underlying Tarski's
characterization is that no such thing can happen to logical
expressions; the logical expressions retain their intended meaning in a
model, no matter under which permutation of the objects in the model's
domain we consider them.[^14]

[^14]: For a more precise explanation of the criterion, see @macfarlane_j:2015[section 5] and @bonnay:2014 for
 an overview of recent work on it. An influential line of objection
 to invariance-based characterizations of logical constants can for
 example be traced through @hanson_wh:1997, @mccarthy_tg:1981, @mcgee_v:1996, @sagi_gi:2015, and @zinke:2018a.

One of the main questions about the notion of logical consequence is how
the precise, model-theoretic notion relates to the intuitive,
pre-theoretical notion of logical entailment with which we operate in
ordinary reasoning. The idea that the former can be extracted from natural language, 
and in particular Glanzberg's recent critique of this idea, are discussed 
in Gil Sagi's contribution to the special issue.

That there is an explanatory gap to be filled here
has already been pointed out by Tarski, who writes that 

> the concept of
> following is not distinguished from other concepts of everyday language
> by a clearer content or more precisely delineated denotation [...] and
> one has to reconcile oneself in advance to the fact that every precise
> definition of the concept [...] will to a greater or lesser degree bear
> the mark of arbitrariness. [-@tarski_a:2002, 176]

An influential contribution to the debate about logical consequence
which takes this question as its starting point is Etchemendy
[-@etchemendy_j:1990]. Roughly, Etchemendy argues that Tarski's model-theoretic definition of logical consequence fails to capture the
intuitive notion of logical consequence, since it presupposes certain
contingent, non-logical assumptions about the cardinality of the
universe, putting the notion defined by Tarski at odds with the
necessity of the intuitive notion.[^15]

[^15]: See @caret-hjortland:2015a[5f] and @zinke:2018[section 5.3]
 and see @zinke:2018[section 5.1] for a different argument along similar lines.

# Formal Languages

There are different formal methods which one can apply to evaluate the
logical validity of an argument. One may for example rely on semantic
methods, such as those provided by a model theoretic semantics, or on
syntactical methods, such as the one provided by the natural deduction
calculus.[^16] In order to apply such formal methods to systematically
assess the quality of an argument, the premises and conclusions of
arguments have to be translated from the natural language in which they
are stated into a suitable formal language. The process of translating a
sentence of a natural language into a formal language is the process of
formalizing in the narrow sense, as opposed to the wider sense which
pertains to whole arguments.

[^16]: That logic can help us decide on the validity of an argument
 formulated in a natural language is a standard assumption. It is
 however challenged by @baumgartner_m-lampert:2008, who argue
 that the formalization of an argument should rather be understood as
 a means to explicate the argument by bringing out the formal
 structure on which the natural language argument is based.

Besides this central technical reason, there are further reasons for
formalizing arguments. One important reason is that given a suitable
formal language, formalizing an argument forces us to clarify, in
different respects, its premises and conclusion. One respect of
clarification concerns the many ambiguities present in natural language.
Formal languages are often explicitly constructed to be unambiguous, so
that each sentence (or formula, if one prefers) of the language is
assigned a single, precise meaning. A well-worn example are ambiguous
natural language sentences involving quantifier phrases such as "Every
child gets a present." Translating the sentence into the formal language
of first-order logic, we are forced to decide between two unambiguous
readings of the sentence (that every child gets its own present(s) or
that every child gets the same present(s)) by the variable-binding
structure of the quantifiers of the formal language. @dutilhnovaes:2012[ch. 4 and 7], furthermore argues that there is
another respect in which formalization helps us clarify the formalized
parts of language, namely that formal languages serve to eliminate
certain cognitive biases.

From the perspective of logic, formal languages are first and foremost
mathematical objects.[^17] More specifically, they are identified with
sets of formulas, where a formula is a sequence of symbols which is
generated from a set of symbols, the formal language's alphabet, based
on a set of syntactic rules which give us a recipe for generating all
well-formed formulas of the respective language. The resulting formal
language is of course still devoid of meaning, as it merely gives us an
alphabet of symbols and rules for constructing certain sequences of
them. To interpret the language, a semantics which defines meanings for
all well-formed formulas of the language is needed. The standard
approach is to identify these meanings with truth-values, reflecting the
idea that semantics is about true or false representation of an
underlying structure which the sentences of a language reflect or fail
to reflect. But there is also an inferentialist tradition which aims to
characterize meaning in terms of the inferential rules which govern the
expressions of the language.[^18]

[^17]: But see @dutilhnovaes:2012[ch. 2] for
 discussion.

[^18]: See e.g. @sellars_w:1953, @brandom:1994, @peregrin:2014.

Formal languages and their semantic interpretations are legion, but what
constrains our choice of a formal language when formalizing an argument?
This section will focus on one rather important constraint, namely the
expressive strength of the formal language. General philosophical
constraints about the notions involved in an argument one wants to
formalize or pragmatic or sociological constraints tied to certain
context will hence not be discussed.

The notion of expressive strength is a semantic notion which concerns
not only an uninterpreted formal language, but rather a pairing of such
a language with a suitable semantics. It seems that, at least in some
cases, there is a notable asymmetry in the relation between the language
and the semantics when it comes to determining expressive strength: We
cannot extend the expressive strength of some language beyond a certain
threshold set by the expressions it contains by coupling it with a
different semantics. An example is the language of propositional logic
which simply lacks the syntactic expressions needed to capture the inner
logical structure of atomic formulas which grounds the felicity of
certain inferences which come out as valid in classical first-order
logic. One could try to compensate for the lack of syntactic structure
by adopting a particular translation scheme and by encoding the validity
of the logically invalid inferences in the semantics. E.g. if the
predicate "$F$" stands for "is a dog" and "$G$" for "is an animal", then
the valid first-order inference from "$\forall x (Fx \rightarrow Gx)$" and
"$\exists x Fx$" to "$\exists x Gx$" could be simulated in the language of
propositional logic by assigning a propositional constant to the English
sentences "All dogs are animals", "There is a dog", and "There is an
animal" and by building it into one's semantics of the language of
propositional logic that the two first entail the third. But there are
obvious limits to this strategy, since it e.g. makes the semantics
depend on a particular translation-schema from a natural into the formal
language and since it would make it a matter of stipulation which
propositional constants express logical truths or stand in relations of
logical entailment.

In order to allow us to adequately formalize an argument, the formal
language (together with a suitable semantic interpretation), has to be
able to capture enough of the logical structure of the argument as
stated in a natural language to make it an argument, i.e. a collection
of sentences one of which stands in a relation of inferential support to
the others. Intensional logic offers a wealth of examples which
highlight expressive limitations of certain formal languages. A
classical example from tense logic concerns the formalization of the
sentence [see e.g. @cresswell_mj:1990, 18]:

(@thirteen) One day all persons now alive will be dead.

In the language of a simple tense logic which extends the language of
first-order logic with the sentential tense-operators $\mathbf{P}$ ("It
was the case that...") and $\mathbf{F}$ ("It will be the case that..."),
if one uses the predicates $A,D$ for "... is alive" and "... is dead"
respectively, the closest one can get to an adequate formalization of (@thirteen)
is:

(@fourteen) $\mathbf{F} \forall x (Ax\rightarrow Dx)$

Since this formula says that it will be the case at a future time that
everyone alive at that time is dead at that time, this translation is
clearly inadequate. There are different ways to remedy this lack of
expressive strength. One is to add a sentential "now"-operator
$\mathbf{N}$ and to introduce a double-indexed semantics for the
language which allows one to evaluate formulas relative to not one but
two time indices, one of which is specifies the time of evaluation.[^20] Figuratively speaking, $\mathbf{N}$'s semantic contribution to a
formula is to force the evaluation of the formula in its scope at the
time of evaluation. So in

[^20]: See e.g. @vlach:1973, @kamp_h:1971.

(@fifteen) $\mathbf{F} \forall x (\mathbf{N}Ax\rightarrow Dx)$

$\mathbf{N}$'s job is to exempt the atomic formula $Ax$ from being
evaluated at the future time index introduced by $\mathbf{F}$ and to
force its evaluation at the time index representing the time of
evaluation, i.e. present time from the perspective of someone evaluating
the formula. The result is an adequate formalization of (@thirteen) which could
e.g. be used in the formalization an argument involving (@fifteen) as a premise.

Interestingly, (@thirteen) can also be expressed without temporal operators, if
we instead allow the quantifiers of the language to range over times,
relativize predications to times, so that "$Axt$" and "$Dxt$" stand for
"$x$ is alive at time $t$" and "$x$ is dead at time $t$" respectively,
and take $t_0$ to stand for the time of evaluation [@cresswell_mj:1990, 19]:

(@sixteen) $\exists t_1 (t_0 < t_1 \land \forall x (A(xt_0)\rightarrow D(xt_1)))$

This formula seems to adequately capture what (@thirteen) says relative to a
particular time of evaluation. Note that, as @cresswell_mj:1990[21] points out, it might be argued to be
objectionable that (@sixteen) produces an eternal sentence for each value of
$t_0$. At least it is, if we assume that the truth-value of (@thirteen) could
change, if e.g. technological advances would allow humans to attain
immortality.

The availability of (@sixteen) as a translation of (@thirteen) raises the question of
whether it wouldn't be preferable to just work with the language of
first-order logic rather than with the extended language of first-order
tense logic which adds new operators. Considerations of parsimony
certainly seem to favour this strategy. Why introduce additional
operators if we can express the same things without them? Philosophical
reasons may be brought to bear on this question. Arthur Prior for
example argued that the tense logical formalization of (@thirteen) is preferable,
considerations of parsimony notwithstanding, since he took tense, which
is more naturally expressed using operators like
$\mathbf{F}$, $\mathbf{P}$, and $\mathbf{N}$, to be more fundamental than
time.[^21] 

Questions about the choice of formal language are discussed in Hanoch Ben-Yami 
and, with a historical focus on Frege's *Begriffsschrift*, 
in Jongool Kim's contributions to the special issue.

[^21]: See @cresswell_mj:1990[22] and see @lewis_dk:1968
 for the development of counterpart theory, a theory expressible in
 the language of first-order logic which can express any sentence
 which can be expressed in the language of first-order modal logic.

# Quality-Criteria for Formalization

## Translation Problems and a Simple Quality Constraint

Assuming that a suitable formal language has been selected, determining
the logical form of a natural language sentence is still not a
straightforward matter. It seems clear that not every formula of such a
language can equally well be used to translate every natural language
sentence. But what then makes a formula or a set of formulas an adequate
or a correct formalization? Can we formulate general criteria for the
quality or admissibility for formalizations of a formal language?[^22]

[^22]: This is a topic which has surprisingly not been discussed much in
 the literature. Adequacy criteria for formalizations in first-order
 logic are for example discussed in @baumgartner_m-lampert:2008; @baumgartner_m:2010b, @blau_u:1977, @brun_g:2004 [@brun_g:2012], @epstein_rl:1994, and @sainsbury:2001.

A minimal constraint on the correctness of formalization of sentences is
that it should respect certain intuitively valid inferences involving
these sentences. In this subsection, the focus will be on two well-known
examples of problem cases for translations of natural language sentences
into the language of first-order logic which illustrate two different
attempts to ensure that this minimal constraint is met.

The first problem specifically concerns a particular type of sentence,
namely that of action sentences. Consider the following sentence:

(@seventeen) Donald embraced Orman at noon.

The most-straightforward translation of this sentence into the language
of first-order logic is

(@eighteen) $Edon$

where $Exyz$ is the three-place predicate "$x$ embraces $y$ at time $z$"
and $d$, $o$, $n$ are individual constants designating Donald, Orman, and the
relevant point in time respectively. The problem with this formalization
of the sentence is that it does not respect the inferential relation
between (@seventeen) and the following sentence:

(@nineteen) Donald embraced Orman.

Clearly, if Donald embraced Orman at noon, Donald embraced Orman. Yet,
if we translate (@nineteen) in the same straightforward manner as (@seventeen), using a
two-place predicate $Fxy$ which stands for a sentence of the form "$x$
embraces $y$", we get the following formula:

(@twenty) $Fdo$

But this formula is not logically entailed, in classical first-order
logic, by (@eighteen). A classic discussion of this problem is found in @davidson_d:1967. Building on previous work by Reichenbach and Kenny,
Davidson's solution to the problem is to propose an alternative
formalization-pattern for sequences describing events. According to his
proposal, (@seventeen) should be formalized as:

(@twone) $\exists x (Gxdo \land Hxn)$,

Here the predicate $Gxyz$ stands for "$x$ is an embrace by $y$ of $z$",
the predicate $Hxy$ for "$x$ happened at time $y$", and the constants
$d$, $o$, $n$ retain their earlier referents. This new formula directly
entails the formula

(@twtwo) $\exists x Gxdo$

which, following Davidson's formalization pattern, is an adequate
formalization of (@nineteen). The problem is hence solved.

Davidson's proposal gives us an example of a formalization pattern which
is sensitive to the content of the formalized sentence. As Davidson put
it: "Part of what we must learn when we learn the meaning of any
predicate is how many places it has, and what sorts of entities the
variables that hold these places range over. Some predicates have an
event-place, some do not" [-@davidson_d:1967, 93]. Given the
previous discussion about the distinction between formal and material
inferences, one might think that Davidson's proposal blurs the line
between the two kinds of inferences, if such a line can at all be drawn.
One might indeed think that both the example discussed by Davidson and
the example to be discussed next illustrate that it is, even in the case
of first-order logic, a genuinely open question to which extent formal
logic can account for the informal notion of entailment, including
ostensibly material entailments such as those from (@seven) to (@eight) and from (@nine) to (@ten).

The second example illustrates a problem case of formalization which
arises even if one accepts external constraints on formalization. A
classical example discussed in the literature is De Morgan's problem:[^23]

[^23]: See @brun_g:2004[sect. 9, 189ff]. See also @brun_g:2012.

(@twthree) All horses are animals.

(@twfour) $\therefore$ All heads of horses are heads of animals.

There is a straightforward way to formalize (@twthree) by simply translating "is
a horse" using the predicate-letter $F$ and "is an animal" using the
predicate letter $G$:

(@twfive) $\forall x (Fx \rightarrow Gx)$

If we formalize (@twfour) in the same manner using the predicate-letter $H$ for
"is a head of a horse" and $I$ for "is the head of an animal", we end up
with:

(@twsix) $\forall x (Hx \rightarrow Ix)$

If we just consider (@twfour) in isolation, this is may be a fine
formalization, but (@twsix) is inadequate in the context of a formalization of
the argument from (@twthree) to (@twfour). The inference captured in this argument is
intuitively correct, but (@twfive) does not logically entail (@twsix) .

There are different formalizations of (@twfour) which solve the problem [cf.
@brun_g:2004, 93]. One solution is to formalize (@twfour) as follows,
using the binary predicate $K$ to translate "is the head of" in addition
to $F$ and $G$ which are still used to translate "is a horse" and "is an
animal" respectively:

(@twseven) $\forall x \forall y ((Fy \land Kxy ) \rightarrow (Gy \land Kxy ))$

Alternatively, the following formula also does the trick:

(@tweight) $\forall x (\exists y(Fy \land Kxy) \rightarrow \exists y(Gy \land Kxy ))$

Both (@twseven) and (@tweight) are logical consequences of (@twfive), so both (@twfive) and (@twseven), as
well as (@twfive) and (@tweight) give us formalizations of the argument from (@twthree) to (@twfour)
which can be said to meet the minimal requirement set out earlier in
this section. Interestingly however, (@twseven) is logically stronger than (@tweight) in
the sense that (@tweight) is a logical consequence of (@twseven), but (@twseven) not of (@tweight). The
fact that we can have two different, but non-equivalent ways of
formalizing the argument from (@twthree) to (@twfour) raises several general questions
about the formalization of arguments [cf. @brun_g:2004, 194]. We
might for example ask whether the two variants can be compared
concerning their quality as formalizations of the natural language
argument they translate, and if so, which one of them offers us the
better formalization.

The discussion of the two classical formalization problems illustrate
two important general aspect of how we determine the correctness of a
formalization. The first and quite obvious point is that the intuitive
notion of inference we apply when reasoning using natural language gives
us a corrective for correct formalization. The correctness of a
formalization can never be a completely formal matter; i.e. logic alone
can never tell us whether a formula is a correct formalization of a
sentence.[^24] Second, whether a formula of a formal language is an
adequate formalization of a natural language sentence cannot be
determined by considering the sentence in isolation. Correctness rather
is a holistic notion which has to take relevant inferential patterns in
natural language into account. (Cf. Friedrich Reinmuth's contribution to
this special issue.)

[^24]: Which is of course not to say that we cannot use formal methods
 to reason about correctness, see @paseau:2019.

These two points give us constraints on adequate formalization, but they
obviously fall short of giving us general criteria for the adequateness
of formalizations which might, e.g. answer the mentioned questions about
the comparative quality of equally admissible alternative
formalizations.

## General Quality Criteria

What shape could such a general criterion take? Brun distinguishes two
kinds of quality criteria, *correctness criteria* and *adequacy
criteria* [see -@brun_g:2004, 11]. In his terminology, a
formalization is *correct* if its validity-relevant features are just
those of the sentence or of the argument which it formalizes. But there
is a fundamental problem for formalizing arguments which shows that
correctness alone is not enough to guarantee that a formalization is a
good formalization. Following @blau_u:1977, this problem has come
to be known as the problem of unscrupulous formalization.[^25] To see
the problem, consider the following example given in @brun_g:2004[238]:

[^25]: Blau's German term is "skrupellose Formalisierung" [see -@blau_u:1977, 18].

(@twnine) Every prime number is odd or equal to 2.

(@thirty) There is no prime number which is not odd and not equal to 2.

These two sentences can arguably be recognized to say the same without
thinking much about their logical form, e.g. by pondering the meanings
of "every" and "there is no." Let us, for the sake of the argument,
assume that we accept on an intuitive level that (@twnine) and (@thirty) are
equivalent. Using "$P$" for "is a prime number" and "$O$" for "is an odd
number", a scrupulous formalization of the two sentences would give us
the two following formulas:

(@thirtyone) $\forall x (Px \rightarrow (Ox \lor x=2))$

(@thirtytwo) $\neg \exists x (Px \land (\neg Ox \land \neg x=2))$

Given these translations, we could now provide a formal explanation of
our informal judgement that (@twnine) and (@thirty) are equivalent by proving that the
two formulas are equivalent in first-order logic. An unscrupulous
formalization in contrast would for example be one which translates both
(@twnine) and (@thirty) as (@thirtyone). The goal of our exercise in formalization is to show
that we can confirm our informal judgement that (@twnine) and (@thirty) are equivalent
and there is no easier equivalence proof than one which demonstrates
that a formula, trivially, but correctly, is equivalent to itself. The
point of the example is that if correctness is all that matters, then
there the unscrupulous formalization is as good as the scrupulous one.

The example of unscrupulous formalizations shows that correctness alone
is not a guarantee of the quality of a formalization. This is where
adequacy enters the picture. Adequacy is a stricter quality-criterion
than correctness, that is, each adequate formalization is a correct
formalization, but not vice versa. The notion of adequacy hence allows
us to rule out correct, but still problematic formalizations of the sort
just discussed. Unscrupulous formalization give us a clear
adequacy-constraint: Adequate formalizations do not trivialize
non-trivial inferential connections between the resulting formulas,
ruling out e.g. a formalization which translates both (@twnine) and (@thirty) as (@thirtyone).
Accordingly, adequacy criteria go beyond correctness criteria in the
sense that they ensure that the formalization not only captures the
validity-relevant features of the formalized sentences or argument, but
also does so in a non-trivial way.

There are, just as in case of the notion of logical entailment, two
different conceptions of correctness which are tied to two conceptions
of what validity-relevant features are. First, these features can be the
truth-conditions of the relevant sentences and formulas, giving us a
semantic conception of correctness. The idea then is that a
formalization is correct if the formalization has the same
truth-conditions as the sentence it formalizes relative to a logic and a
translation-schema (or correspondence schema in Brun's terms) which
specifies the translations of all relevant expressions of natural
language into the relevant formal language.[^26]

[^26]: See the correctness principle (WK) in @brun_g:2004[210].

The validity-relevant features can however also be inferential features,
giving us a syntactic conception of correctness. For arguments, the
formalization and the formalized argument as stated in natural language
have to have the same inferential structure, whereas for the
formalization of a single sentence, the formalization is correct if the
formally correct inferences in which it can occur are also valid in an
informal sense for the corresponding inferences made in natural
language.[^27]

[^27]: See the correctness principle (SK) in @brun_g:2004[214].

The minimal constraint mentioned in the previous subsection hence
concerns the second, the inferential, notion of correctness. Sainsbury
discusses the following adequacy criterion for formalizations of English
sentences:

::: statement
**QC1**. A formalization is adequate only if each of its logical constants is
matched by a single English expression making the same contribution
to truth conditions. [@sainsbury:2001, 352]
:::

\noindent This proposal is motivated by Sainsbury's discussion of what he calls
the "Tractarian vision", that every entailment is a logical entailment.
Friends of this idea might be tempted to ensure that material
entailments are really logical entailments by putting more structure
into the formalizations than the surface form of the sentences requires.
They might for example try to ensure that the argument from (@seven) ("The ball
is red") to (@eight) ("The ball is coloured") counts as logically valid by
formalizing its premise and conclusion as follows:

(@thirtythree) $Rb \land Cb$

(@thirtyfour) $Cb$

A problem with this sort of translation and, more generally, with the
Tractarian vision is that it appears to conflate the two distinct
projects of analysing the meaning of a sentence and of isolating its
logical form.[^28] The motivation for formalizing (@seven) as (@thirtythree) has to draw
on the semantic fact that to say that an object is red is, implicitly,
to say that it is coloured. To ensure that the entailment is logical,
the proposed formalization hence draws on a fact about the meaning of
the non-logical expressions involved in (@seven). So while the formalization of
the argument works on the formal level, it indirectly violates the
formality requirement: The formality of the logical entailment between
(@thirtythree) and (@thirtyfour) is not mirrored by the premise and conclusion of the
argument as stated in English. Sainsbury's adequacy criterion QC1
systematically blocks ad hoc logicalizations of arguments of this sort.
[^29]

[^28]: See @sainsbury:2001[354]. Note that such
 translations would also count as unscrupulous in Blau's and Brun's
 sense.

[^29]: Note that this problem would not arise in the first place in a
 logically perfect language of the sort which Wittgenstein
 characterizes in the *Tractatus*. In such a language, all logically
 simple sentences are fully analyzed in the sense that they do not
 contain any hidden logical or semantic structure which could be
 brought out by formalizing them.

A drawback of QC1 is that it also threatens Davidson's proposed
formalization schema for action sequences: There is arguably no single
English expression in "Donald embraced Orman at noon" which makes the
same contribution to the sentences's truth conditions as the existential
quantifier in its formalization (@twone) does with respect to that formula of
first-order logic.

Purists who eschew the content sensitivity of Davidson's formalization
pattern might see this as an advantage rather than a drawback, but Brun
argues that QC1 suffers from two further problems which are less
specific and more severe [see @brun_g:2004, 253f]. First, it
presupposes an explanation of what it means for a natural language
expression to match or correspond to a logical constant in a formula of
the formal language into which one translates. Second, putting the first
problem aside, while QC1 rules out some problematic formalizations, such
as (@thirtythree), it likewise rules out uncontroversial formalizations, including
in particular:

(@thirtyfive) Müller is sad, Schmidt is happy.

(@thirtysix) $Sm \land Hs$

(@thirtyseven) Crocodiles are green.

(@thirtyeight) $\forall x (Cx \rightarrow Gx)$

(@thirtynine) Hans owns a red bicycle.

(@fourty) $\exists x (Bx \land Rx \land Ohx)$

The comma in (@thirtyfive) can hardly be said to make the same contribution to its
truth-conditions as the conjunction in (@thirtysix) and the same can be said
about the quantifier and the material conditional in (@thirtyeight) and the
existential quantifier, as well as the two conjunctions in (@fourty). QC1
helps rooting out some inadequate formalizations, but it throws the baby
out with the bathwater by classifying a range of standard formalizations
as inadequate.

There are however better adequacy criteria than QC1, such as the
following, (a simplified version of) Brun's criterion of less precise
formalization which gives us a necessary condition for the adequacy of a
formalization:

::: statement
**QC2**. For a formula $\phi$ to be a correct formalization of a sentence
$A$, every formula $\psi$ which is less precise than $\phi$ has to
be such that there is a correct formalization of $A$ which is a
notational variant of $\psi$.[^30]
:::

[^30]: Cf. principle (UGK), @brun_g:2004[349].

\noindent This principle needs a bit of unpacking.[^31] First of all, "less
precise" is here understood to be a relation which holds between two
formulas $\phi$ and $\psi$ relative to a formalism (i.e. a logic), which
are formalizations of the same sentence and which are such that $\psi$
can be generated from $\phi$ by substituting a logically more complex
formula for a sub-formula of $\phi$. Of two such formulas, one is less
precise than the other if the former gives us a less detailed picture of
the logical structure of the sentence. Consider for example the
following sentence:

[^31]: Just as with the principle itself, I will in the following
 simplify the details of Brun's account which is explained in full
 detail in [-@brun_g:2004, sections 13.2 and 13.4].

(@fourtyone) Paul Otto Alfred is an adopted son.

Letting the constant $a$ stand for the name "Paul Otto Alfred" and the
predicate $P$ for "is an adopted son", we can formalize (@fourtyone) as:

(@fourtytwo) $Pa$

However, we could also use the two predicates $Q$ and $R$, standing for
"is adopted" and "is a son" to formalize (@fourtyone) as:

(@fourtythree) $Qa \land Ra$

Or we could still be more precise and formalize (@fourtyone) as follows using the
predicate $S$ to translate "is male" and $T$ to translate "is the father
of":

(@fourtyfour) $Qa \land Sa \land \exists x (Txa)$

(@fourtytwo)--(@fourtyfour) are all formalizations of the same sentence, namely (@fourtyone);
furthermore, each of the three formulas can be generated by substitution
from the others;[^32] finally, the three formulas are increasingly
precise, revealing more and more of the formalized sentence's logical
structure.

[^32]: E.g. we get (@fourtythree) from (@fourtytwo) by substituting $Pa$ by $Qa \land Ra$ and
 (@fourtyfour) from (@fourtythree) by substituting $Sa \land \exists x (Txa)$ for $Ra$.

QC2 also involves the notion of a notational variant. This notion can be
understood in terms of substitution: A formula $\phi$ is a notational
variant of a formula $\psi$ if, and only if, $\phi$ can be transformed
into $\psi$ by a one-to-one substitution of non-logical predicates and
vice versa (see @brun_g:2004, 301).

Now how does QC2 work? We can think of a logically complex formalization
as the result of a step-by-step procedure which starts with an atomic
formula and then begins capturing more of the formalized sentence's
logical structure by analyzing it in terms of more complex formulas
which all are correct in the semantic sense of having the right
truth-conditions. What QC2 tells us is basically that to be an adequate
formalization is to only contain logical complexity which can be the
result of such a process of refinement. (@fourtyfour) for example counts as
adequate in this sense, since if we condense the second conjunction into
a single formula, we in any case get a formula which is a notational
variant of (@fourtythree), and which is a semantically correct formalization of the
sentence.

With that said, let us return to De Morgan's problem and the two
non-equivalent, but seemingly both admissible formalizations of (@twfour), (@twseven)
and (@tweight):

(27) $\forall x \forall y ((Fy \land Kxy ) \rightarrow (Gy \land Kxy ))$

(28) $\forall x (\exists y(Fy \land Kxy) \rightarrow \exists y(Gy \land Kxy ))$

Can QC2 help us decide whether one of the two is a more adequate
formalization of (@twfour), the conclusion of De Morgan's argument? Note first
that neither of these two formulas is more precise than the other in the
relevant sense, since the quantifiers and variables the two formulas
contain prevent us from generating one from the other by substituting a
logically more complex formula for a sub-formula in either of the two.
However, only one of the two formulas, namely (@twseven) stands in the "is more
precise than"-relation to (@twsix):

(@fourtyseven) $\forall x (Hx \rightarrow Ix)$

We can generate (@twseven) from (@twsix) by substituting $\exists y(Fy \land Kxy)$ and
$\exists y(Gy \land Kxy)$ for $Hx$ and $Ix$ respectively. (@tweight) cannot be
generated in the same way, since the second universal quantifier in (@tweight)
cannot be introduced by substituting logically more complex formulas for
sub-formulas of (@twsix). The closest we can get to (@twsix) is:

(@fortyeight) $\forall x \forall y (Mxy \rightarrow Nxy)$

However, it is not clear what the predicates $M$ and $N$ could stand
for. Since both are relational predicates, $M$ would have to correspond
to something like "is a horse head of" and $N$ to "is an animal head
of." Be that as it may, since (@fortyeight) is a less precise formula than (@twseven),
QC2 tells us that (@tweight) is an inadequate formalization of (@twfour), unless
there is a notational variant of (@fortyeight) which is an adequate formalization
of (@twfour) ("All heads of horses are heads of animals"). If (@fortyeight) turned
out to be a notational variant of (@twsix), then this condition would be
met. However, this is not the case, since due to the presence of the
second universal quantifier in (@twseven), we cannot generate it from (@twsix) by
one-for-one substituting its non-logical predicates. So whether (@twseven) is
an adequate formalization of (@twfour) depends on whether (@fortyeight) is an adequate
formalization of (@twfour).

This opens up a way to informally argue that only (@tweight) is an adequate
formalization of (@twfour) by arguing that (@fortyeight) is not a notational variant
of an adequate formalization of (@twfour). Given QC2, the adequacy of (@fortyeight)
cannot be justified by pointing out that it is a less precise formula
than the adequate formalization (@twseven) since it is exactly the adequacy of
(@twseven) which is at issue, so an independent justification is needed. One
might then for example argue that the additional logical complexity of
(@fortyeight) gives us a reason to prefer (@twseven) instead, or one might also target
the seemingly unnatural translation schema one would have to adopt to
make sense of (@fortyeight).[^34]

[^34]: Note that Brun uses an additional adequacy criterion to more
 formally argue that (@tweight), and not (@twseven), is an adequate formalization
 of (@twfour) (see -@brun_g:2004[352--356].

# Choice of Logic

Since our focus here is on deductive logic, the formalisms one has to
choose from when formalizing an argument are different logics. The one
logic which has the claim to being the default choice is classical
first-order logic. It has this status in virtue of some of its formal
properties---classical first-order logic is e.g. complete and sound---and
its expressive strength. First-order logic can be used to formalize a
range of mathematical theories, including e.g. some set theories and, as
we have seen, it can be used to express the same, or at least similar
claims, as intensional logics such as tense logic or modal logic [see
@lewis_dk:1968].

Still, there appear to be reasons to rely on alternative logics. One
reason is that one may be compelled to reject logical principles or
inference schemata which hold in e.g. classical first-order logic with
respect to certain contexts, or topics, or more generally for
philosophical reasons. Free logic provides an example of the latter
sort. As Karel Lambert describes it, free logic is "free of existence
assumptions with respect to its terms, general and singular" [-@lambert_k:1981a, 123]. Classical first-order logic involves the
assumption that every singular term (e.g. each constant) refers to an
object in the domain of quantification.[^35] This, free logicians
argue, is problematic. Consider for example the sentence:

[^35]: See e.g. @frege:1893[9, note 31].

(@fortynine) Heimdallr exists.

In the language of first-order logic, this sentence can be formalized as
follows, using the constant $h$ for Heimdallr:

(@fifty) $\exists x (h = x)$

Literally, this formula says that there exists something the same as
Heimdallr. Both this logico-literal restatement and (@fortynine) itself are, at
least insofar as common sense is concerned, false, since Heimdallr is an
object of fiction, i.e. an object which does not exist. Given the
mentioned assumption about the reference of singular terms, this formula
is however a logical truth of classical first-order logic. If we accept
first-order logic, we hence seem to be forced to accept an obvious
falsehood as true.[^36] Free logic offers a way out of this problem,
since it allows for the falsity of formulas like (@fifty). This is because
unlike in classical logic, the rule of Existential Generalization:

[^36]: There are ways to evade this argument, e.g. by adopting the
 descriptivist theory of proper names famously proposed in @russell_b:1905. The dominant view about the reference of proper
 names, according to which they are directly referential [cf. @kripke:1980], however, speaks against Russell's theory.

(@fiftyone) $A \vdash \exists x A(x/t)$

fails in free logic. Here, $A$ is a formula of the language of first
order logic and $A(x/t)$ is the formula which results if we replace any
occurrence of the individual constant $t$ by the variable $x$ (if there
are any). Existential Generalization allows us to e.g. infer from (the
formalization in the language of first-order predicate logic of)
"Heidallr owns Gjallarhorn" to the existence of something which owns
Gjallarhorn. In free logic, this inference is not valid, since, briefly
put, that a sentence is satisfied by a particular individual constant
does not entail the existence of an object in the domain of discourse
which satisfies the formula.[^37] Other reasons for adopting particular
(non-classical) logics which have been given in the philosophical
literature include its adequacy for explaining vagueness (cf. e.g.
@machina_kf:1976 or @smith_njj:2008), or the need to move
to a non-classical logic in order to avoid semantic paradoxes such as
the liar paradox [cf. e.g. @kripke:1975].

[^37]: See @nolt:2014 for a general overview and further
 explanation.

It is a fact that there are different logics, but which one should we
rely on in analyzing arguments? Carnap famously adopted a tolerant
stance towards logic. He assumed that any choice of logic is permissible
in principle and that which logic one relies on is ultimately a matter
of its usefulness for a particular purpose.[^38] However, Carnap's
tolerant attitude is not shared by everyone and we may ask whether,
despite the fact that there are different logics, there is one logic
which is correct in the sense that it gives us the one correct notion of
logical consequence. This question is asked in the recent discussion
about logical pluralism, the view that there is more than one correct
logic and therefore also more than one correct notion of logical
consequence.[^39] A recently proposed methodology for choosing between 
logics based on reflective equilibrium is criticized in Bogdan Dicher's 
contribution to the special issue. A question about the independence of 
formalization and choice of logic is raised in Roy Cook's contribution.

[^38]: See in particular Carnap's principle of tolerance, as set out
 e.g. in @carnap:1947[§17].

[^39]: See @beall-restall:2006 and @shapiro_s:2014 for developments of the position, @field_h:2009c, @priest_g:2006, @read_s:2006a for opposing views, and @russell_gi:2019 for an overview.

# Genesis of the Special Issue and Acknowledgements

The initial idea for this special issue came about during the workshop
"Making it (too) precise" which I organized together with Dominik
Aeschbacher and Maria Scarpati in July 2017 at the University of Geneva
as part of the SNSF-funded research project "Indeterminacy and Formal
Concepts" (project nr. 156554) led by Prof. Kevin Mulligan. After the
editorial committee of *Dialectica* approved the proposal for the
special issue, an open call for papers was published online. 18 papers
in total were submitted, including some of those presented at the
workshop in Geneva. All of these paper were subject to the same review
process which mirrored that passed by regular submissions to
*dialectica*, with the sole differences being that the guest editor was
both responsible for the organization of the review process and for the
initial internal review. The 13 papers which passed this initial step
were double-anonymously reviewed by two expert reviewers. In a third and
final step, the papers which were selected by the guest editor based on
the recommendations of the reviewers were presented to the editorial
committee and the editors who approved the guest editor's decision.

First and foremost, I would like to thank the authors for contributing
their papers and allowing them to be published in this special issue. My
second greatest debt is to all the reviewers whose work made it possible
for an interested bystander like myself to take editorial decisions. I
would also like to thank the editorial committee of *Dialectica*,
especially Matthias Egg for his helpful comments and its managing editor Philipp Blum, for giving
me the opportunity to edit and for approving the special issue and the
Swiss National Science Foundation for financial support at the outset
("Indeterminacy and Formal Concepts", University of Geneva 2014--17,
project number 156554, PI: Kevin Mulligan). Finally, I would
like to thank Philipp Blum and all the people involved 
for the work they put into turning
*Dialectica* into an open access journal. It is a very happy
coincidence, one which only materialized after the reviewing process had
been well under way, that this special issue would be the first issue of
the journal to be freely and openly accessible to anyone over the
internet.

# Overview of the Papers of the Special Issue

In his paper "The Quantified Argument Calculus and Natural Logic",
Hanoch Ben-Yami relates his Quantified Argument Calculus (acronym:
*Quarc*) to Larry Moss's Natural Logic. The main selling point of both
of these logical systems is that they give us logics which are able to
account for the validity of certain intuitively correct argument types,
such as for example the argument from (@seven) to (@eight), which are invalid in
classical first-order logic. Ben-Yami shows that Quarc is able to
account for the same extended range of arguments which Moss's Natural
Logic is designed to capture and furthermore argues that Quarc has the
advantage that it does not require to posit negative nouns to do so.

In "Reflective Equilibrium on the Fringe: The Tragic Threefold Story
of a Failed Methodology for Logical Theorising," Bogdan Dicher
critizises the idea [proposed e.g. in @goodman_n:1955 and more
recently in @peregrin-svoboda:2017] that reflective equilibrium can
serve as a method for choosing a logic. The core idea of this approach
is that the fact that the rules of inference of a logic and the
inferences in natural language which it is supposed to formalize can be
brought into a (virtuously circular) agreement with each other provides
us with a criterion for that logic's adequacy. Dicher's argument against
this idea is based on three case studies, one focusing on the impact on
harmony of moving from a single- to a multiple-conclusion, another
focusing on the question of how we may distinguish between logics which
deliver the same valid logical entailments, focusing on classical
first-order logic and strict-tolerant logic [@cobreros-etal:2012],
and a third focusing on an application of the logic of
first-degree entailment [@anderson_ar-belnap:1975] by Beall.

Jongool Kim's paper "The Primacy of the Universal Quantifier in
Frege's Concept-Script" focuses on the question of why Frege adopted
the universal, rather than the existential quantifier as a primitive of
the formal system developed in his @frege:1879. This question
is not only of historical interest, given that Frege's book is one of
the most important contributions to the development of contemporary
logic, but also raises a general systematic question about factors
motivating the choice of a particular formal language. While Frege never
explicitly answered this question, Kim extracts, develops, and discusses
three arguments which support this choice from Frege's works and singles
out one of them, a philosophical argument based on the idea that
choosing the existential quantifier as a primitive instead would have
undermined Frege's logicist project of putting arithmetic on a purely
logical foundation, as the strongest.

Friedrich Reinmuth's paper "Holistic Inferential Criteria of Adequate
Formalization" focuses on adequacy criteria for logical formalization.
Following e.g. @brun_g:2004, @peregrin-svoboda:2017 and
others, Reinmuth assumes that such criteria have to be holistic in the
sense that they have to take into account the consequences of the choice
one makes in formalizing a particular natural language sentence not only
for the target argument, but also for all other arguments involving the
same sentence as a premise or conclusion. He points out shortcomings in
existing proposals and motivates and develops criteria which extend from
arguments to more complex sequences of logical reasoning and which e.g.
allow one to distinguish between equivalent formalizations of arguments
which nonetheless lead to differences when embedded in such sequences.

Gil Sagi's paper "Considerations on Logical Consequence and Natural
Language" focuses on the relation between the notion of logical
consequence and ordinary language. Sagi in particular targets three
recent arguments due to @glanzberg:2015 to the conclusion
that the relation of logical consequence cannot be simply read off
natural language. Her paper rebuts these arguments and argues that one
of the two positive proposals made by Glanzberg for how one might go
beyond natural language in order to get at logical consequence is in
fact compatible with the view that this relation exists in natural
language.

In "'Unless' is 'Or', Unless '$\neg A$ Unless $A$' is Invalid", Roy
T. Cook discusses the formalization of arguments involving the
expression "unless", focussing in particular on the differences between
formalizations which rely on the same formal language, that of
propositional logic, but differ in that they assume classical or
intuitionistic logic as the background logic. One of Cook's main points
is that his discussion questions the assumption that translations from
informal into formal language are logic neutral, in the sense that we
can settle for a logical formalization independently of first adopting a
particular logic.

Vladan Djordjevic's paper "Assumptions, Hypotheses, and Antecedents"
focuses on an important distinction between three ways in which
deductive arguments can be cast both in formal languages and in natural
language. Djordjevic distinguishes "arguments from assumptions", which
are arguments in which each premise is assumed to be logically true and
the logical truth of the conclusion is to be established, from
"arguments from hypotheses," in which the validity of an inference from
the premises to the conclusion is at issue, and from assertions of
conditionals which are also sometimes used to contain the premises of an
argument in their antecedent and its conclusion. The three categories
are often conflated and Djordjevic argues that certain philosophical
puzzles, including a standard argument for fatalism and McGee's
counterexample to Modus Ponens can be resolved based on these
distinctions.

# References
