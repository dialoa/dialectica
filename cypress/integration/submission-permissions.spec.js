describe('submission-permissions', () => {

  beforeEach(function () {
    // "this" points at the test context object
    //cy.fixture('user').as('user')

    cy.request('http://localhost:3000/test/destroy_all_submissions')
    cy.request('http://localhost:3000/test/destroy_all_users')
    cy.request('http://localhost:3000/test/destroy_all_external_referees')
  })

  afterEach(function(){
    //cy.destroy_user_account()
    //cy.login_as_reviewer();
  })

  it('checks who is able to access submission_pool', () => {

    cy.visit('http://localhost:3000/submissions');
    cy.contains("You need to sign in or sign up before continuing.", { matchCase: false })

    cy.login_as_author();
    cy.visit('http://localhost:3000/submission_pool');
    cy.contains("you are not authorized to perform this action.")
    cy.logout();

    cy.login_as_reviewer();
    cy.visit('http://localhost:3000/submission_pool');
    cy.contains("fishpond", { matchCase: false });
    cy.logout();

    cy.login_as_editor();
    cy.visit('http://localhost:3000/submission_pool');
    cy.contains("fishpond", { matchCase: false });
    cy.logout();
  });


});
