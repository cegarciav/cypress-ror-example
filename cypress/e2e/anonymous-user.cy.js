describe('Anonoymous user visiting the site', () => {
  beforeEach(() => {
    cy.exec('make db-restart')
      .its('code')
      .should('eq', 0);
  });

  it('passes', () => {
    cy.visit('/');
  });
});
