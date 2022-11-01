describe('Registered user visiting the site', () => {
  beforeEach(() => {
    cy.exec('make db-restart')
      .its('code')
      .should('eq', 0);
  });

  it('should be able to log in with their username', () => {
    cy.visit('/');

    // Go to /login view
    cy.contains('a', 'Log In').click();
    cy.url().should('include', '/login');

    // Login form
    cy.get('input[id="username"]').type('nmuntz');
    cy.get('input[id="password"]').type('colección-de-estampas-haha');

    cy.contains('input', 'Log In').click();

    // Redirection to homepage
    cy.url().should(
      'eq',
      `${Cypress.config("baseUrl")}/`,
    );
    cy.contains('a', 'New Article');
  });
});
