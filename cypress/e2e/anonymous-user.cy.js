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

  it('should be able to sign up as a user', () => {
    cy.visit('/');

    // Go to /signup view
    cy.contains('a', 'Sign Up').click();
    cy.url().should('include', '/signup');

    // Sign up form
    cy.contains('h1', 'Create a new account');
    cy.get('input[id="email"]').type('elsa@arendelle.com');
    cy.get('input[id="name"]').type('Elsa');
    cy.get('input[id="username"]').type('elsa_arendelle');
    cy.get('input[id="password"]').type('letitgo123');
    cy.get('input[id="password2"]').type('letitgo123');

    cy.contains('input', 'Sign Up').click();

    // Redirection to homepage
    cy.url().should(
      'eq',
      `${Cypress.config("baseUrl")}/`,
    );
    cy.contains('a', 'New Article');
  });

  it('should block a user to sign up with an existing email', () => {
    cy.visit('/');

    // Go to /signup view
    cy.contains('a', 'Sign Up').click();
    cy.url().should('include', '/signup');

    // Sign up form
    cy.contains('h1', 'Create a new account');
    cy.get('input[id="email"]').type('nelson.haha@gmail.com');
    cy.get('input[id="name"]').type('Nelson Rufino');
    cy.get('input[id="username"]').type('nelson_rufino');
    cy.get('input[id="password"]').type('spanish-version');
    cy.get('input[id="password2"]').type('spanish-version');

    cy.contains('input', 'Sign Up').click();

    // Redirection to /signup but with an error message
    cy.url().should('include', '/signup');
    cy.contains('p', 'Email already registered');
  });
});
