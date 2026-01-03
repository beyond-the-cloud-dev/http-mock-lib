<template>
  <footer class="btc-footer">
    <!-- Background decorative elements -->
    <div class="footer-bg-effects">
      <div class="bg-blob bg-blob-1"></div>
      <div class="bg-blob bg-blob-2"></div>
    </div>

    <div class="footer-main">
      <div class="footer-container">
        <!-- Desktop Layout -->
        <div class="footer-grid desktop-only">
          <!-- Company Info Column -->
          <div class="company-column">
            <div class="company-header">
              <img src="/images/logo.png" alt="Beyond The Cloud" class="company-logo" />
              <div class="company-title">
                <span class="company-tagline">{{ data.company.tagline }}</span>
              </div>
            </div>
            <p class="company-description">{{ data.company.description }}</p>
            <div class="partner-badge">
              <img src="/images/salesforcePartnerBadgeHorizontal.png" alt="Salesforce Partner" class="sf-badge-img" />
            </div>
          </div>

          <!-- Links Columns -->
          <div class="links-grid">
            <!-- Column 1: This Site + Services -->
            <div class="links-column">
              <div v-if="currentContextLinks.length > 0" class="link-section">
                <h4 class="section-title">This Site</h4>
                <ul class="link-list">
                  <li v-for="link in currentContextLinks" :key="link.label">
                    <a :href="link.href">{{ link.label }}</a>
                  </li>
                </ul>
              </div>
              <div class="link-section" :class="{ 'mt-section': currentContextLinks.length > 0 }">
                <h4 class="section-title">Services</h4>
                <ul class="link-list">
                  <li v-for="link in data.services" :key="link.label">
                    <a :href="link.href">{{ link.label }}</a>
                  </li>
                </ul>
              </div>
            </div>

            <!-- Column 2: Open Source -->
            <div class="links-column">
              <div class="link-section">
                <h4 class="section-title">Open Source</h4>
                <div class="opensource-content">
                  <a :href="data.openSource.parent.href" class="parent-link">
                    {{ data.openSource.parent.label }}
                    <span class="star-icon">★</span>
                  </a>
                  <ul class="child-links">
                    <li v-for="child in data.openSource.children" :key="child.label">
                      <span class="arrow-icon">→</span>
                      <a :href="child.href">{{ child.label }}</a>
                    </li>
                  </ul>
                  <a :href="data.openSource.more.href" class="more-link">
                    {{ data.openSource.more.label }} ↗
                  </a>
                </div>
              </div>
            </div>

            <!-- Column 3: Products + Resources -->
            <div class="links-column">
              <div class="link-section">
                <h4 class="section-title">Products</h4>
                <ul class="link-list">
                  <li v-for="link in data.products" :key="link.label">
                    <a :href="link.href">{{ link.label }}</a>
                  </li>
                </ul>
              </div>
              <div class="link-section mt-section">
                <h4 class="section-title">Resources</h4>
                <ul class="link-list">
                  <li v-for="link in data.resources" :key="link.label">
                    <a :href="link.href">{{ link.label }}</a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>

        <!-- Mobile Layout -->
        <div class="footer-mobile mobile-only">
          <!-- Company Info -->
          <div class="mobile-company">
            <div class="company-header">
              <img src="/images/logo.png" alt="Beyond The Cloud" class="company-logo" />
              <div class="company-title">
                <span class="company-tagline">{{ data.company.tagline }}</span>
              </div>
            </div>
            <p class="company-description">{{ data.company.description }}</p>
            <div class="partner-badge">
              <img src="/images/salesforcePartnerBadgeHorizontal.png" alt="Salesforce Partner" class="sf-badge-img" />
            </div>
          </div>

          <!-- Mobile Links -->
          <div class="mobile-links">
            <div v-if="currentContextLinks.length > 0" class="mobile-section">
              <h4 class="section-title">This Site</h4>
              <ul class="link-list">
                <li v-for="link in currentContextLinks" :key="link.label">
                  <a :href="link.href">{{ link.label }}</a>
                </li>
              </ul>
            </div>

            <div class="mobile-section">
              <h4 class="section-title">Services</h4>
              <ul class="link-list">
                <li v-for="link in data.services" :key="link.label">
                  <a :href="link.href">{{ link.label }}</a>
                </li>
              </ul>
            </div>

            <div class="mobile-section">
              <h4 class="section-title">Open Source</h4>
              <div class="opensource-content mobile-opensource">
                <a :href="data.openSource.parent.href" class="parent-link">
                  {{ data.openSource.parent.label }}
                  <span class="star-icon">★</span>
                </a>
                <ul class="child-links">
                  <li v-for="child in data.openSource.children" :key="child.label">
                    <span class="arrow-icon">→</span>
                    <a :href="child.href">{{ child.label }}</a>
                  </li>
                </ul>
                <a :href="data.openSource.more.href" class="more-link">
                  {{ data.openSource.more.label }} ↗
                </a>
              </div>
            </div>

            <div class="mobile-section">
              <h4 class="section-title">Products</h4>
              <ul class="link-list">
                <li v-for="link in data.products" :key="link.label">
                  <a :href="link.href">{{ link.label }}</a>
                </li>
              </ul>
            </div>

            <div class="mobile-section">
              <h4 class="section-title">Resources</h4>
              <ul class="link-list">
                <li v-for="link in data.resources" :key="link.label">
                  <a :href="link.href">{{ link.label }}</a>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Bottom Bar -->
    <div class="footer-bottom">
      <div class="footer-container bottom-container">
        <!-- Desktop Bottom -->
        <div class="bottom-content desktop-only">
          <div class="bottom-left">
            <span>© {{ currentYear }} Beyond The Cloud</span>
            <span class="separator">•</span>
            <span>{{ data.company.nip }}</span>
            <span class="separator">•</span>
            <span>{{ data.company.address }}</span>
            <span class="separator">•</span>
            <a :href="data.legal.privacyPolicy" class="privacy-link">Privacy Policy</a>
          </div>
          <div class="bottom-right">
            <a :href="'mailto:' + data.company.email" class="email-link">{{ data.company.email }}</a>
            <div class="social-icons">
              <a v-for="social in data.social" :key="social.name" :href="social.href" :aria-label="social.name" class="social-icon" target="_blank" rel="noopener noreferrer">
                <img :src="'/images/social/' + social.icon + '.svg'" :alt="social.name" class="social-img" />
              </a>
            </div>
          </div>
        </div>

        <!-- Mobile Bottom -->
        <div class="bottom-content-mobile mobile-only">
          <div class="mobile-social">
            <a v-for="social in data.social" :key="social.name" :href="social.href" :aria-label="social.name" class="social-icon" target="_blank" rel="noopener noreferrer">
              <img :src="'/images/social/' + social.icon + '.svg'" :alt="social.name" class="social-img" />
            </a>
          </div>
          <a :href="'mailto:' + data.company.email" class="email-link mobile-email">{{ data.company.email }}</a>
          <div class="mobile-legal">
            <span>© {{ currentYear }} Beyond The Cloud</span>
            <span class="separator">•</span>
            <a :href="data.legal.privacyPolicy" class="privacy-link">Privacy Policy</a>
          </div>
        </div>
      </div>
    </div>
  </footer>
</template>

<script setup>
import { computed } from 'vue'
import { footerData, contextLinks } from '../footer-data.js'

// Props
const props = defineProps({
  context: {
    type: String,
    default: 'apex-fluently'
  }
})

// Data
const data = footerData

// Computed
const currentYear = computed(() => new Date().getFullYear())
const currentContextLinks = computed(() => contextLinks[props.context] || [])
</script>

<style scoped>
/* CSS Custom Properties */
.btc-footer {
  --btc-blue: #0092c8;
  --btc-blue-alt: #1c93c8;
  --btc-light-blue: #80d8fd;
  --btc-gray: #424242;
  --btc-dark-gray: #2c2c2c;
  --btc-text: #aaa;
  --btc-text-muted: #888;
  --btc-border: #424242;

  background: var(--btc-dark-gray);
  color: #d1d5db;
  position: relative;
  overflow: hidden;
  margin-top: 4rem;
  width: 100vw;
  margin-left: calc(-50vw + 50%);
  margin-right: calc(-50vw + 50%);
}

/* Background Effects */
.footer-bg-effects {
  position: absolute;
  inset: 0;
  opacity: 0.05;
  pointer-events: none;
}

.bg-blob {
  position: absolute;
  width: 384px;
  height: 384px;
  border-radius: 50%;
  filter: blur(64px);
}

.bg-blob-1 {
  top: 0;
  left: 25%;
  background: var(--btc-blue);
}

.bg-blob-2 {
  bottom: 0;
  right: 25%;
  background: var(--btc-light-blue);
}

/* Layout */
.footer-main {
  position: relative;
}

.footer-container {
  max-width: 1280px;
  margin: 0 auto;
  padding: 64px 24px 32px;
}

.bottom-container {
  padding: 20px 50px;
}

/* Desktop Grid */
.footer-grid {
  display: flex;
  gap: 48px;
}

.company-column {
  flex: 0 0 280px;
  max-width: 320px;
}

.links-grid {
  flex: 1;
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 40px;
}

/* Company Header */
.company-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 20px;
}

.company-logo {
  width: auto;
  height: 40px;
  border-radius: 12px;
  object-fit: contain;
}

.company-title {
  display: flex;
  flex-direction: column;
}

.company-tagline {
  color: var(--btc-light-blue);
  font-size: 15px;
  max-width: 120px;
}

.company-description {
  color: var(--btc-text);
  font-size: 14px;
  line-height: 1.6;
  margin-bottom: 24px;
}

/* Partner Badge */
.partner-badge {
  display: inline-flex;
  align-items: center;
}

.sf-badge-img {
  height: 60px;
  width: auto;
  object-fit: contain;
}

/* Section Titles */
.section-title {
  color: rgba(255, 255, 255, 0.5);
  font-weight: 600;
  font-size: 11px;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  margin-bottom: 16px;
}

/* Link Lists */
.link-list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.link-list a {
  color: var(--btc-text);
  font-size: 14px;
  text-decoration: none;
  transition: color 0.2s;
}

.link-list a:hover {
  color: var(--btc-light-blue);
}

.mt-section {
  margin-top: 24px;
}

/* Open Source Section */
.opensource-content {
  text-align: left;
}

.parent-link {
  color: var(--btc-light-blue);
  font-weight: 500;
  font-size: 14px;
  text-decoration: none;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  margin-bottom: 8px;
}

.parent-link:hover {
  color: #fff;
}

.star-icon {
  font-size: 12px;
}

.child-links {
  list-style: none;
  padding: 0;
  margin: 0 0 12px 0;
  display: flex;
  flex-direction: column;
  gap: 6px;
  padding-left: 8px;
}

.child-links li {
  display: flex;
  align-items: center;
}

.arrow-icon {
  color: var(--btc-blue);
  margin-right: 8px;
  font-size: 12px;
}

.child-links a {
  color: var(--btc-text);
  font-size: 14px;
  text-decoration: none;
  transition: color 0.2s;
}

.child-links a:hover {
  color: var(--btc-light-blue);
}

.more-link {
  color: var(--btc-text-muted);
  font-size: 12px;
  text-decoration: none;
  transition: color 0.2s;
}

.more-link:hover {
  color: var(--btc-text);
}

/* Bottom Bar */
.footer-bottom {
  border-top: 1px solid var(--btc-border);
}

.bottom-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.bottom-left {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 12px;
  color: var(--btc-text-muted);
  font-size: 12px;
}

.separator {
  color: var(--btc-text-muted);
}

.privacy-link {
  color: var(--btc-text-muted);
  text-decoration: none;
  transition: color 0.2s;
}

.privacy-link:hover {
  color: var(--btc-text);
}

.bottom-right {
  display: flex;
  align-items: center;
  gap: 20px;
}

.email-link {
  color: var(--btc-text);
  font-size: 14px;
  text-decoration: none;
  transition: color 0.2s;
}

.email-link:hover {
  color: var(--btc-light-blue);
}

/* Social Icons */
.social-icons {
  display: flex;
  gap: 4px;
}

.social-icon {
  width: 36px;
  height: 36px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--btc-gray);
  color: var(--btc-text);
  transition: all 0.2s;
}

.social-icon:hover {
  background: var(--btc-blue);
  color: #fff;
  transform: translateY(-2px);
}

.social-img {
  width: 20px;
  height: 20px;
  object-fit: contain;
}

/* Mobile Styles */
.desktop-only {
  display: flex;
}

.mobile-only {
  display: none;
}

@media (max-width: 1024px) {
  .desktop-only {
    display: none !important;
  }

  .mobile-only {
    display: block !important;
  }

  .footer-container {
    padding: 48px 24px 32px;
  }

  /* Mobile Company */
  .mobile-company {
    text-align: center;
    margin-bottom: 40px;
  }

  .mobile-company .company-header {
    justify-content: center;
  }

  .mobile-company .company-title {
    text-align: left;
  }

  .mobile-company .company-description {
    max-width: 320px;
    margin: 0 auto 24px;
  }

  .mobile-company .partner-badge {
    justify-content: center;
  }

  /* Mobile Links */
  .mobile-links {
    display: flex;
    flex-direction: column;
    gap: 32px;
  }

  .mobile-section {
    text-align: center;
  }

  .mobile-section .link-list {
    align-items: center;
  }

  .mobile-opensource {
    display: inline-block;
    text-align: left;
  }

  /* Mobile Bottom */
  .bottom-content-mobile {
    text-align: center;
  }

  .mobile-social {
    display: flex;
    justify-content: center;
    gap: 8px;
    margin-bottom: 16px;
  }

  .mobile-social .social-icon {
    width: 40px;
    height: 40px;
  }

  .mobile-email {
    display: block;
    margin-bottom: 12px;
  }

  .mobile-legal {
    color: var(--btc-text-muted);
    font-size: 12px;
  }
}

@media (max-width: 480px) {
  .footer-container {
    padding: 40px 16px 24px;
  }

  .bottom-container {
    padding: 16px;
  }
}
</style>
