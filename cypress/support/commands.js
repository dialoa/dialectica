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
Cypress.Commands.add('login', (email, password) => {
  cy.visit('localhost:3000')
  cy.get("[data-cy=form_for_login]").within(($form) => {
    cy.get('#user_email').type(email)
    cy.get('#user_password').type(password)
    cy.root().submit()
  })
  cy.contains('Erfolgreich angemeldet.')
})

Cypress.Commands.add('login', (email, password) => {
  cy.visit('localhost:3000')
  cy.get("[data-cy=form_for_login]").within(($form) => {
    cy.get('#user_email').type(email)
    cy.get('#user_password').type(password)
    cy.root().submit()
  })
  cy.contains('Erfolgreich angemeldet.')
})

Cypress.Commands.add('logout', () => {
  cy.get("[data-cy=logout]").click()
  cy.contains('Erfolgreich abgemeldet.')
})

Cypress.Commands.add('destroy_user_account', () => {
  cy.get("[data-cy=destroy_user_account]").click()
  cy.contains('Ihr Konto wurde gelöscht. Wir hoffen, dass wir Sie bald wiedersehen.')
})
