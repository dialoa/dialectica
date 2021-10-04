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
    cy.contains("submissions", { matchCase: false });
    cy.logout();
  });

  it('creates submission with csv', () => {

    cy.request('http://localhost:3000/test/generate_fake_submissions_and_jsons');
    cy.request('http://localhost:3000/test/destroy_all_submissions')

    cy.login_as_editor();
    cy.visit('http://localhost:3000/submissions');

    cy.get('[data-cy=upload_csv_form]').within(($form) => {
      cy.get('#upload_csv_field_tag').attachFile('first_batch_of_submissions.csv');

      cy.root().submit();
    });



    cy.fixture('first_batch_of_submissions.json').then((submissions) => {
      for (var index = 0; index < submissions.length; index++) {
        cy.contains("done: " + index);
      }
    })

    cy.url().should('eq', 'http://localhost:3000/submission_pool') 

    cy.fixture('first_batch_of_submissions.json').then((submissions) => {
      for (var index = 0; index < submissions.length; index++) {
        cy.contains(submissions[index]["title"]);
      }
    })

    cy.logout();
  });

});
