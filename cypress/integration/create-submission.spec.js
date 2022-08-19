describe('Create Submission', () => {

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

  it('submits a submission, expects the reviewer and editor to see it and editor to delete it.', () => {
    cy.visit('http://localhost:3000/submissions/new');
    cy.contains("new submission to Dialectica");
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
        //cy.setTinyMceContent('submission_comment', submission.comment);

        })
      cy.root().submit();
    });

      cy.contains("submission was successfully created.");
      cy.logout();

      //reviewer
      cy.login_as_reviewer();
      cy.visit('http://localhost:3000/submission_pool')

      cy.fixture('submission.json').then((submission) => {
        cy.contains(submission.title).click();
        cy.contains(submission.title)
        //cy.contains(submission.comment)
      });
      cy.logout();

      //editor
      cy.login_as_editor();
      cy.visit('http://localhost:3000/submission_pool')

      cy.fixture('submission.json').then((submission) => {
        cy.contains(submission.title).click();
        cy.contains(submission.title)
        //cy.contains(submission.comment)
        //deletes it
        cy.contains("delete this submission").click();
        cy.contains("submission was successfully deleted.");
      });

      cy.logout();

  });

  it('submits a submission and the editor edits it', () => {
    cy.visit('http://localhost:3000/submissions/new');
    cy.contains("new submission to Dialectica");
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
        //cy.setTinyMceContent('submission_comment', submission.comment);

        })
      cy.root().submit();
    });

      cy.contains("submission was successfully created.");
      cy.logout();

      //editor
      cy.login_as_editor();
      cy.visit('http://localhost:3000/submission_pool');

      cy.fixture('submission.json').then((submission) => {
        cy.contains(submission.title).click();
      });

      cy.get('[data-cy=edit_submission_button]').first().click();

      cy.get('[data-cy=edit_submission_form]').within(($form) => {
        cy.fixture('submission2.json').then((submission) => {
          cy.get('#submission_title').clear().type(submission.title)
          //cy.get('#submission_email').clear().type(submission.email)
          cy.get('#submission_firstname').clear().type(submission.firstname)
          cy.get('#submission_lastname').clear().type(submission.lastname)
          cy.get('#submission_other_authors').clear().type(submission.other_authors)
          cy.get('#submission_country').then($country => {$country.val(submission.country)})
          cy.get('#submission_file').attachFile('sample.pdf');
          //cy.get('#submission_comment').type(submission.comment)
          //cy.setTinyMceContent('submission_comment', submission.comment);

          })
        cy.root().submit();
      });

      cy.visit('http://localhost:3000/submission_pool');
      cy.fixture('submission2.json').then((submission) => {
        cy.contains(submission.title).click();
        cy.contains(submission.title)
        //cy.contains(submission.comment)
      });

      cy.logout();

  });

  it('submits an empty submission and expects error messages', () => {
    cy.visit('http://localhost:3000/submissions/new');
    cy.contains("new submission to Dialectica");
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
    cy.contains("new submission to Dialectica");
    cy.get('[data-cy=new_submission_form]').within(($form) => {
      cy.get('#submission_file').attachFile('sample.png');
      cy.root().submit();
    });
    cy.contains("File is not a PDF");
  });

});
