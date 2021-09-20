// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add('login', (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add('drag', { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add('dismiss', { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This will overwrite an existing command --
// Cypress.Commands.overwrite('visit', (originalFn, url, options) => { ... })
Cypress.Commands.add('login_as_reviewer', () => {
  cy.visit('http://localhost:3000/users/sign_in')
  cy.get("[data-cy=user_login_form]").within(($form) => {
    cy.get('#user_login').type("reviewer@gmail.com")
    cy.get('#user_password').type("epikur")
    cy.root().submit()
  })
  cy.contains('Signed in successfully.')
})

Cypress.Commands.add('login_as_editor', () => {
  cy.visit('http://localhost:3000/users/sign_in')
  cy.get("[data-cy=user_login_form]").within(($form) => {
    cy.get('#user_login').type("editor@gmail.com")
    cy.get('#user_password').type("epikur")
    cy.root().submit()
  })
  cy.contains('Signed in successfully.')
})


Cypress.Commands.add('logout', () => {
  cy.get("[data-cy=logout]").click();
})

Cypress.Commands.add('destroy_user_account', () => {
  cy.get("[data-cy=destroy_user_account]").click()
  cy.contains('Ihr Konto wurde gelöscht. Wir hoffen, dass wir Sie bald wiedersehen.')
})
