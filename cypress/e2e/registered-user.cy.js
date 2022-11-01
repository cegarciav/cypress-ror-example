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

  it('should be able to log in with their email', () => {
    cy.visit('/');

    // Go to /login view
    cy.contains('a', 'Log In').click();
    cy.url().should('include', '/login');

    // Login form
    cy.get('input[id="username"]').type('nelson.haha@gmail.com');
    cy.get('input[id="password"]').type('colección-de-estampas-haha');

    cy.contains('input', 'Log In').click();

    // Redirection to homepage
    cy.url().should(
      'eq',
      `${Cypress.config("baseUrl")}/`,
    );
    cy.contains('a', 'New Article');
  });

  it('should allow a logged-in user to create a new article', () => {
    cy.visit('/');

    // Go to /login view
    cy.contains('a', 'Log In').click();
    cy.url().should('include', '/login');

    // Login form
    cy.get('input[id="username"]').type('nelson.haha@gmail.com');
    cy.get('input[id="password"]').type('colección-de-estampas-haha');

    cy.contains('input', 'Log In').click();

    // Redirection to homepage
    cy.url().should(
      'eq',
      `${Cypress.config("baseUrl")}/`,
    );

    // Create a new article
    const articleTitle = 'New test from Cypress';
    const articleDescription = 'If you see this, we were able to create a new article';
    const articleImage = 'https://m.media-amazon.com/images/I/418r9PmmoSL._SL500_.jpg';
    cy.contains('a', 'New Article').click();
    cy.get('input[id="title"]').type(articleTitle);
    cy.get('input[name="description"]').type(articleDescription);
    cy.get('#image_url').type(articleImage);

    cy.get('form').submit()

    // Redirection to homepage
    cy.url().should(
      'eq',
      `${Cypress.config("baseUrl")}/`,
    );
    cy.contains('h1', articleTitle);
    cy.contains('p', articleDescription);
    cy.get('img')
      .should('have.attr', 'src')
      .should('eq',articleImage);
  });
});
