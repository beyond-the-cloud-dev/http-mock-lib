import { defineConfig } from 'vitepress'

export default defineConfig({
  title: "HTTP Mock Lib",
  description: "A fluent API for mocking HTTP callouts in Salesforce Apex tests",
  base: '/',
  themeConfig: {
    logo: '/logo.png',

    nav: [
      { text: 'Home', link: '/' },
      { text: 'Guide', link: '/getting-started' },
      { text: 'API', link: '/api/' }
    ],

    sidebar: [
      {
        text: 'Introduction',
        items: [
          { text: 'Getting Started', link: '/getting-started' },
          { text: 'Installation', link: '/installation' }
        ]
      },
      {
        text: 'API Reference',
        items: [
          { text: 'Overview', link: '/api/' },
          { text: 'HTTP Methods', link: '/api/http-methods' },
          { text: 'Response Body', link: '/api/response-body' },
          { text: 'Content Types', link: '/api/content-types' },
          { text: 'Status Codes', link: '/api/status-codes' },
          { text: 'Headers', link: '/api/headers' }
        ]
      },
      {
        text: 'Examples',
        items: [
          { text: 'Basic Usage', link: '/examples/basic' },
          { text: 'Multiple Endpoints', link: '/examples/multiple-endpoints' },
          { text: 'Custom Headers', link: '/examples/custom-headers' },
          { text: 'Error Handling', link: '/examples/error-handling' }
        ]
      }
    ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/beyond-the-cloud-dev/http-mock-lib' }
    ],

    footer: {
      message: 'Part of <a href="https://apexfluently.beyondthecloud.dev">Apex Fluently</a>',
      copyright: 'Copyright © 2024 <a href="https://beyondthecloud.dev">Beyond the Cloud</a>'
    },

    search: {
      provider: 'local'
    }
  }
})
