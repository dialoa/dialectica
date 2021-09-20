describe('Submission Reviewer Tools', () => {

  beforeEach(function () {
    cy.login_as_reviewer();
  });

  afterEach(function(){
    cy.logout();
  });

  it("adds submission to the current user, shows up in the user's pool and removes it again.", () => {
    const uuid = () => Cypress._.random(0, 1e6)
    const id = uuid()
    const testname = `testname${id}`
    cy.create_submission(testname)

    cy.get('[data-cy=submissions_add_user_to_submission]').first().click(); //fish this
    cy.contains("signed up as internal referee");

    cy.visit('http://localhost:3000/submission_pool');

    cy.contains("submissions to be reviewed by me").first().click();
    cy.contains(testname).first().click();

    cy.get('[data-cy=submissions_remove_user_to_submission]').first().click(); //fish this
    cy.contains("quit as internal referee ");
  });

  it("adds a comment to submission.", () => {
    const comment_text = "This is my comment on this submission";
    const uuid = () => Cypress._.random(0, 1e6)
    const id = uuid()
    const testname = `testname${id}`
    cy.create_submission(testname);

    cy.get('[data-cy=add_comment_to_submission_button]').first().click();
    cy.setTinyMceContent('comment_comment', comment_text);
    cy.get('[data-cy=submit_comment_to_submission_button]').first().click();

    cy.contains(comment_text);
    //cy.get('[data-cy=]').first().click();
  });

  it("uploads a file to a submission.", () => {
    const uuid = () => Cypress._.random(0, 1e6)
    const id = uuid()
    const testname = `testname${id}`
    cy.create_submission(testname);

    cy.get('[data-cy=upload_file_button]').first().click();
    cy.get('#upload_file_field_tag').attachFile('sample.pdf');
    cy.get('[data-cy=submit_upload_file_button]').first().click();


    cy.contains("uploaded a file: sample.pdf");
    //cy.get('[data-cy=]').first().click();
  });


});
