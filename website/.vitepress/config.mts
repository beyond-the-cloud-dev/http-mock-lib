import { defineConfig } from 'vitepress'
import llmstxt from 'vitepress-plugin-llms'

const siteUrl = 'https://httpmock.beyondthecloud.dev'
const siteTitle = 'HTTP Mock Lib'
const siteDescription = 'Open-source Apex library for mocking HTTP callouts in Salesforce unit tests. Fluent API to define responses per endpoint and HTTP method, with body, content type, status code, headers and exceptions. Free, MIT licensed, part of Apex Fluently by Beyond The Cloud.'

export default defineConfig({
  cleanUrls: true,
  lang: 'en-US',
  title: siteTitle,
  description: siteDescription,
  base: '/',
  head: [
    ['link', { rel: 'icon', href: '/favicon.ico' }],
    ['meta', { name: 'author', content: 'Beyond The Cloud' }],
    ['meta', { property: 'og:type', content: 'website' }],
    ['meta', { property: 'og:site_name', content: siteTitle }],
    ['meta', { property: 'og:image', content: `${siteUrl}/logo.png` }],
    ['meta', { name: 'twitter:card', content: 'summary' }],
    [
      'script',
      { type: 'application/ld+json' },
      JSON.stringify({
        '@context': 'https://schema.org',
        '@type': 'SoftwareApplication',
        name: siteTitle,
        description: siteDescription,
        url: siteUrl,
        applicationCategory: 'DeveloperApplication',
        operatingSystem: 'Salesforce',
        license: 'https://opensource.org/licenses/MIT',
        codeRepository: 'https://github.com/beyond-the-cloud-dev/http-mock-lib',
        isPartOf: { '@type': 'SoftwareApplication', name: 'Apex Fluently', url: 'https://apexfluently.beyondthecloud.dev' },
        offers: { '@type': 'Offer', price: '0', priceCurrency: 'USD' },
        author: {
          '@type': 'Organization',
          name: 'Beyond The Cloud',
          url: 'https://beyondthecloud.dev',
          sameAs: ['https://github.com/beyond-the-cloud-dev', 'https://www.linkedin.com/company/beyondtheclouddev']
        }
      })
    ]
  ],
  sitemap: {
    hostname: siteUrl
  },
  vite: {
    plugins: [llmstxt({ domain: siteUrl })]
  },
  transformPageData(pageData) {
    let canonicalUrl = `${siteUrl}/${pageData.relativePath}`
      .replace(/index\.md$/, '')
      .replace(/\.md$/, '')
      .replace(/\/$/, '')
    pageData.frontmatter.head ??= []
    pageData.frontmatter.head.push(
      ['link', { rel: 'canonical', href: canonicalUrl || siteUrl }],
      ['meta', { property: 'og:url', content: canonicalUrl || siteUrl }]
    )
    const pageTitle = pageData.frontmatter.title || pageData.title
    pageData.frontmatter.head.push(
      ['meta', { property: 'og:title', content: pageTitle && pageTitle !== siteTitle ? `${pageTitle} | ${siteTitle}` : siteTitle }],
      ['meta', { property: 'og:description', content: pageData.frontmatter.description || pageData.description || siteDescription }]
    )
  },
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
          { text: 'Headers', link: '/api/headers' },
          { text: 'Exceptions', link: '/api/exceptions' },
          { text: 'Requests', link: '/api/requests' }
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
    footer: false,
    search: {
      provider: 'local'
    }
  }
})
