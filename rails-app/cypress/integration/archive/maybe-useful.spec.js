before(function () {
  //creates 20 submissions
  cy.fixture('submissions.json').then(submissions => {
  submissions.forEach(submission => {
    //start

    cy.visit('http://localhost:3000/submissions/new');
    cy.contains("new submission to dialectica");
    cy.get('[data-cy=new_submission_form]').within(($form) => {
      cy.get('#submission_title').type(submission.title)
      cy.get('#submission_email').type(submission.email)
      cy.get('#submission_firstname').type(submission.firstname)
      cy.get('#submission_lastname').type(submission.lastname)
      cy.get('#submission_other_authors').type(submission.other_authors)
      cy.get('#submission_country').then($country => {$country.val(submission.country)})
      cy.get('#submission_file').attachFile('sample.pdf');
      cy.setTinyMceContent('submission_comment', submission.comment);
      cy.root().submit();
    });
    cy.contains("submission was successfully created.");

    //end
    });
  });


})
