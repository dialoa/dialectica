describe('CV Generator', () => {

  beforeEach(function () {
    // "this" points at the test context object
    //cy.fixture('user').as('user')
  })

  afterEach(function(){
    //cy.destroy_user_account()
  })

  it('submits a submission and expects a message', () => {
    cy.visit('http://localhost:3000/submissions/new');
    cy.contains("new submission to dialectica");
    cy.get('[data-cy=new_submission_form]').within(($form) => {
      cy.fixture('submission.json').then((submission) => {
        cy.get('#submission_title').type(submission.title)
        cy.get('#submission_email').type(submission.email)
        cy.get('#submission_firstname').type(submission.firstname)
        cy.get('#submission_lastname').type(submission.lastname)
        cy.get('#submission_other_authors').type(submission.other_authors)
        cy.get('#submission_country').then($country => {$country.val(submission.country)})
        cy.get('#submission_file').attachFile('sample.pdf');
        //cy.get('#submission_comment').type(submission.comment)
        cy.setTinyMceContent('submission_comment', submission.comment);


        })
      cy.root().submit();
      })

      cy.contains("submission was successfully created.");

  });

  it('submits an empty submission and expects error messages', () => {
    cy.visit('http://localhost:3000/submissions/new');
    cy.contains("new submission to dialectica");
    cy.get('[data-cy=new_submission_form]').within(($form) => {

      cy.root().submit();
      })

      cy.contains("Title can't be blank");
      cy.contains("Firstname can't be blank");
      cy.contains("Lastname can't be blank");
      cy.contains("Email can't be blank");
      cy.contains("File can't be blank");
  });

  it('submits a png instead of a pdf and expects error messages', () => {
    cy.visit('http://localhost:3000/submissions/new');
    cy.contains("new submission to dialectica");
    cy.get('[data-cy=new_submission_form]').within(($form) => {
      cy.get('#submission_file').attachFile('sample.png');
      cy.root().submit();
    });
    cy.contains("File is not a PDF");
  });

});
