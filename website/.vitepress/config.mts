import { defineConfig } from 'vitepress'

export default defineConfig({
  title: "HTTP Mock Lib",
  description: "A fluent API for mocking HTTP callouts in Salesforce Apex tests",
  base: '/',
  themeConfig: {
    logo: '/logo.png',

    nav: [
      { text: 'Home', link: '/' },
      { text: 'Documentation', link: '/api/' }
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
      }
    ],
    socialLinks: [
      { icon: 'github', link: 'https://github.com/beyond-the-cloud-dev/http-mock-lib' },
      {
        icon: 'linkedin',
        link: 'https://www.linkedin.com/company/beyondtheclouddev'
      }
    ],
    footer: {
      message: 'Part of <a href="https://apexfluently.beyondthecloud.dev">Apex Fluently</a>',
      copyright: 'Copyright © 2025 <a href="https://beyondthecloud.dev">Beyond the Cloud</a>'
    },
    search: {
      provider: 'local'
    }
  }
})
