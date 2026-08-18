import fs from 'node:fs'
import path from 'node:path'
import { fileURLToPath } from 'node:url'
import defineVersionedConfig from 'vitepress-versioning-plugin'

const dirname = fileURLToPath(new URL('.', import.meta.url))
const docsRoot = path.resolve(dirname, '..')

const latestVersion = '1.3.0'

/**
 * Every route a docs folder serves, e.g. ['/', '/api/', '/api/headers'].
 * Lets the version switcher jump to the same page in another version
 * instead of dumping the reader on that version's home page.
 */
function routesIn(dir: string, exclude: string[] = []): string[] {
  const routes: string[] = []

  const walk = (absolute: string, relative: string) => {
    for (const entry of fs.readdirSync(absolute, { withFileTypes: true })) {
      if (exclude.includes(entry.name)) continue

      if (entry.isDirectory()) {
        walk(path.join(absolute, entry.name), `${relative}/${entry.name}`)
        continue
      }
      if (!entry.name.endsWith('.md')) continue

      routes.push(
        entry.name === 'index.md'
          ? `${relative}/`
          : `${relative}/${entry.name.slice(0, -'.md'.length)}`
      )
    }
  }

  walk(dir, '')
  return routes.sort()
}

const versionsDir = path.join(docsRoot, 'versions')
const versions = fs.existsSync(versionsDir)
  ? fs
      .readdirSync(versionsDir, { withFileTypes: true })
      .filter((entry) => entry.isDirectory())
      .map((entry) => entry.name)
      .sort()
      .reverse()
  : []

const pages: Record<string, string[]> = {
  latest: routesIn(docsRoot, ['versions', '.vitepress', 'public'])
}
for (const version of versions) {
  pages[version] = routesIn(path.join(versionsDir, version))
}

export default defineVersionedConfig(
  {
    cleanUrls: true,
    title: "HTTP Mock Lib",
    description: "A fluent API for mocking HTTP callouts in Salesforce Apex tests",
    base: '/',

    versioning: {
      latestVersion
    },

    // Required: vitepress-versioning-plugin only generates versioned sidebars
    // while iterating locales, so the default locale must be declared explicitly.
    locales: {
      root: { label: 'English', lang: 'en' }
    },

    themeConfig: {
      logo: '/logo.png',

      // Replaced by ./theme/components/VersionSwitcher.vue, which preserves the
      // current page across versions rather than always linking to `/<version>/`.
      versionSwitcher: false,

      nav: [
        { component: 'VersionedNavLink', props: { text: 'Home', link: '/', versions } },
        { component: 'VersionedNavLink', props: { text: 'Documentation', link: '/api/', versions } },
        { component: 'VersionSwitcher', props: { latest: latestVersion, versions, pages } }
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
  dirname
)
