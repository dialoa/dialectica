describe('update submissions with csv', () => {

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

  it('checks who is able to access submissions', () => {

    cy.visit('http://localhost:3000/submissions');
    cy.contains("You need to sign in or sign up before continuing.", { matchCase: false })


    cy.login_as_reviewer();
    cy.visit('http://localhost:3000/submissions');
    cy.contains("you are not authorized to perform this action.")
    cy.logout();

    cy.login_as_editor();
    cy.visit('http://localhost:3000/submissions');
    cy.contains("submissions", { matchCase: false })
    cy.logout();
  });

  it('creates submission with csv', () => {
    cy.login_as_editor();
    cy.visit('http://localhost:3000/submissions');

    cy.get('[data-cy=upload_csv_button]').first().click();
    cy.get('#upload_csv_field_tag').attachFile('submissions.csv');
    cy.get('[data-cy=submit_upload_csv]').first().click();

    cy.fixture('user.json').then((user) => {
      for (var attribute in user) {
        cy.contains(user[attribute])
      }
    });


    cy.logout();
  });

});
