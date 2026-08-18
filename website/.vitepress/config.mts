import { fileURLToPath } from 'node:url'
import defineVersionedConfig from 'vitepress-versioning-plugin'

export default defineVersionedConfig(
  {
    cleanUrls: true,
    title: "HTTP Mock Lib",
    description: "A fluent API for mocking HTTP callouts in Salesforce Apex tests",
    base: '/',

    versioning: {
      latestVersion: '1.3.0'
    },

    // Required: vitepress-versioning-plugin only generates versioned sidebars
    // while iterating locales, so the default locale must be declared explicitly.
    locales: {
      root: { label: 'English', lang: 'en' }
    },

    themeConfig: {
      logo: '/logo.png',

      versionSwitcher: {
        text: 'Version',
        includeLatestVersion: true
      },

      nav: [
        { text: 'Home', link: '/' },
        { text: 'Documentation', link: '/api/' }
      ],

      sidebar: {
        '/': [
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
              { text: 'Headers', link: '/api/headers' },
              { text: 'Exceptions', link: '/api/exceptions' },
              { text: 'Requests', link: '/api/requests' }
            ]
          },
          {
            text: 'Release Notes',
            items: [{ text: 'Changelog', link: '/release' }]
          }
        ]
      },
      socialLinks: [
        { icon: 'github', link: 'https://github.com/beyond-the-cloud-dev/http-mock-lib' },
        {
          icon: 'linkedin',
          link: 'https://www.linkedin.com/company/beyondtheclouddev'
        }
      ],
      footer: false,
      search: {
        provider: 'local'
      }
    }
  },
  fileURLToPath(new URL('.', import.meta.url))
)
