import { defineConfig } from 'vitepress'
import llmstxt from 'vitepress-plugin-llms'

const siteUrl = 'https://httpmock.beyondthecloud.dev'
const siteTitle = 'HTTP Mock Lib'
const siteDescription = 'Open-source Apex library for mocking HTTP callouts in Salesforce unit tests. Fluent API to define responses per endpoint and HTTP method, with body, content type, status code, headers and exceptions. Free, MIT licensed, part of Apex Fluently by Beyond The Cloud.'

const latest = '1.3.0'

// Frozen: an old version's pages never change again.
const v120 = [
  {
    text: 'Introduction',
    items: [
      { text: 'Getting Started', link: '/1.2.0/getting-started' },
      { text: 'Installation', link: '/1.2.0/installation' }
    ]
  },
  {
    text: 'API Reference',
    items: [
      { text: 'Overview', link: '/1.2.0/api/' },
      { text: 'HTTP Methods', link: '/1.2.0/api/http-methods' },
      { text: 'Response Body', link: '/1.2.0/api/response-body' },
      { text: 'Content Types', link: '/1.2.0/api/content-types' },
      { text: 'Status Codes', link: '/1.2.0/api/status-codes' },
      { text: 'Headers', link: '/1.2.0/api/headers' }
    ]
  },
  { text: 'Release Notes', items: [{ text: 'Changelog', link: '/1.2.0/release' }] }
]

const current = [
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
  { text: 'Release Notes', items: [{ text: 'Changelog', link: '/release' }] }
]

/** Routes each version serves, so the switcher can hold your place across versions. */
const routes = (sidebar, home) => [home, ...sidebar.flatMap((g) => g.items.map((i) => i.link))]
const pages = { [latest]: routes(current, '/'), '1.2.0': routes(v120, '/1.2.0/') }
const versions = ['1.2.0']

export default defineConfig({
  cleanUrls: true,
  lang: 'en-US',
  title: siteTitle,
  description: siteDescription,
  base: '/',

  // Serve website/versions/<version>/**  at  /<version>/**
  rewrites: { 'versions/:version/:rest*': ':version/:rest*' },

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
    let canonicalUrl = `${siteUrl}/${pageData.relativePath.replace(/^versions\//, '')}`
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
      { component: 'VersionedNavLink', props: { text: 'Home', link: '/', versions } },
      { component: 'VersionedNavLink', props: { text: 'Documentation', link: '/api/', versions } },
      { component: 'VersionSwitcher', props: { latest, versions, pages } }
    ],

    sidebar: { '/1.2.0/': v120, '/': current },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/beyond-the-cloud-dev/http-mock-lib' },
      { icon: 'linkedin', link: 'https://www.linkedin.com/company/beyondtheclouddev' }
    ],
    footer: false,
    search: {
      provider: 'local',
      options: {
        // Keep archived versions out of the search index, so results are not a
        // mix of current and superseded docs. VitePress calls this "faceting";
        // it has no built-in support yet.
        _render(src, env, md) {
          if (env.relativePath.startsWith('versions/')) return ''
          const html = md.render(src, env)
          return env.frontmatter?.search === false ? '' : html
        }
      }
    }
  }
})
