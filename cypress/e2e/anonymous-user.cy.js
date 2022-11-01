describe('Anonoymous user visiting the site', () => {
  beforeEach(() => {
    cy.exec('make db-restart')
      .its('code')
      .should('eq', 0);
  });

  it('should be able to access the homepage', () => {
    cy.visit('/');

    // Navbar display right links
    cy.contains('a', 'Log In');
    cy.contains('a', 'Sign Up');
    cy.contains('a', 'Home');

    // Displays the list of articles
    cy.contains('h1', 'List of articles');
    cy.contains('h1', '¿Será posible?');
    cy.contains('h1', 'Festival de cine');
    cy.contains('p', 'Frame de mi cortometraje en el festival de Sundance');
  });
});
