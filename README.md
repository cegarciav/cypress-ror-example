# README

## Based on
https://docs.docker.com/samples/rails/


IMPORTANT: If necessary, run `sudo chown -R $USER:$USER .` after each `docker-compose *` command to gain access to the directory


## Working with the app
1. Based on the `.example.env` file, you should create:
    - An `.env` file for production stage
    - An `.env.dev` file for development stage
    - An `.env.test` file for test stage
2. Run `make build STAGE=${STAGE}` according the stage you need. STAGE can be dev, prod, or test. If STAGE is not given, its default value is test
3. If this is your first time here, you should:
    - Run `make rails-dbcreate STAGE=${STAGE}`
    - Run `make rails-dbmigrate STAGE=${STAGE}`
4. Run `make up STAGE=${STAGE}`
5. Go to your favorite browser and type `http://127.0.0.1:${ROR_HOST_PORT}` (check ROR_HOST_PORT in the `.example.env` file)


## Steps to integrate Cypress with RoR
1. Run `yarn add --dev cypress` or `npm i cypress --save-dev` to install Cypress
2. Run `make up` to start the app
3. In a new console, run `yarn run cypress open` to start Cypress and configure it
4. After global configuration is ready, it's necessary to configure the E2E section. The UI will invite you to create your first `spec.cy.js` file
5. In the `cypress.config.js` file that has automatically been created, you should define the `e2e.baseUrl` variable as `http://127.0.0.1:${ROR_HOST_PORT}` (where ${ROR_HOST_PORT} is the actual value of the variable and not a reference). For instance, if `ROR_HOST_PORT=3001`, you should have a `cypress.config.js` file like this:

```
const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    baseUrl: 'http://127.0.0.1:3001',
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
  },
});
```

You can review an example of this with actual tests in the branch `cypress-integration`


## Further reading
You may also want to check an alternative way to integrate Cypress and RoR by using the gem `cypress-rails`
https://www.bootrails.com/blog/rails-cypress-testing/
https://github.com/testdouble/cypress-rails
