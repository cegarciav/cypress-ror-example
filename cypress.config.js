const { defineConfig } = require("cypress");

module.exports = defineConfig({
  screenshotsFolder: "e2e/cypress_screenshots",
  videosFolder: "e2e/cypress_videos",
  trashAssetsBeforeRuns: false,

  e2e: {
    baseUrl: 'http://127.0.0.1:3001',
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
  },
});
