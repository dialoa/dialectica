describe('Submission Reviewer Tools', () => {

  beforeEach(function () {
    cy.request('http://localhost:3000/test/destroy_all_submissions')
    cy.request('http://localhost:3000/test/destroy_all_users')
    cy.request('http://localhost:3000/test/destroy_all_external_referees')
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

    //cy.contains("to be reviewed by me").first().click();

    cy.get('[data-cy=submission_search_form_for_cards_selection]').select("to be reviewed by me");
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

  it("sends to an external referee and the mail should appear in the history.", () => {
    const mail_text = "hello-this is my custom mail!";
    const uuid = () => Cypress._.random(0, 1e6)
    const id = uuid()
    const testname = `testname${id}`
    cy.create_submission(testname);

    cy.get('[data-cy=submissions_add_user_to_submission]').first().click(); //fish this

    cy.get('[data-cy=send_to_external_referee_button]').first().click();

    cy.get('[data-cy=open-up-fast-create-external-referee-button]').first().click();

    cy.get('[data-cy=fast-create-external-referee_form]').within(($form) => {
      cy.get('#external_referee_firstname').type("Sandro", {delay: 0});
      cy.get('#external_referee_lastname').type("Rass");
      cy.get('#external_referee_email').type("s.raess@me.com");
      //cy.root().submit();
    });
    cy.get('[data-cy=fast-create-external-referee_form]').submit()

    cy.wait(5000);
    cy.get('#send_to_external_referee_external_referee').select("Sandro Rass - s.raess@me.com");

    cy.get('#send_to_external_referee_body').clear().type(mail_text);
    cy.get('[data-cy=submit_send_to_external_referee_button]').first().click();

    cy.contains(mail_text);
    //cy.get('[data-cy=]').first().click();
  });


});
