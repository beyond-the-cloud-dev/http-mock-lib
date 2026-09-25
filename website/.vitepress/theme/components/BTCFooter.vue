<template>
  <footer class="btc-footer">
    <div class="btc-footer__strip">
      <div class="btc-footer__strip-inner">
        <div class="btc-footer__os">
          <h4 class="btc-footer__label">Open Source</h4>
          <a :href="data.openSource.parent.href" class="btc-footer__parent">
            <img
              :src="data.openSource.parent.logo"
              alt=""
              class="btc-footer__parent-logo"
            />
            <span>{{ data.openSource.parent.label }}</span>
          </a>
        </div>
        <div class="btc-footer__tiles">
          <a
            v-for="lib in data.openSource.children"
            :key="lib.id"
            :href="lib.href"
            class="btc-footer__tile"
            :class="{ 'is-current': lib.id === context }"
            :aria-current="lib.id === context ? 'page' : null"
          >
            <img :src="lib.logo" alt="" class="btc-footer__tile-logo" />
            <span class="btc-footer__tile-name">{{ lib.label }}</span>
          </a>
        </div>
      </div>
    </div>

    <div class="btc-footer__body">
      <div class="btc-footer__company">
        <div class="btc-footer__brand">
          <img
            src="/images/logo.png"
            alt="Beyond The Cloud"
            class="btc-footer__logo btc-footer__logo--dark"
          />
          <img
            src="/images/logo-dark.png"
            alt="Beyond The Cloud"
            class="btc-footer__logo btc-footer__logo--light"
          />
          <div class="btc-footer__tagline">{{ data.company.tagline }}</div>
        </div>
        <p class="btc-footer__description">{{ data.company.description }}</p>
        <div class="btc-footer__badge-row btc-footer__desktop">
          <img
            src="/images/salesforcePartnerBadgeHorizontal.png"
            alt="Salesforce Partner"
            class="btc-footer__badge"
          />
          <div class="btc-footer__socials">
            <a
              v-for="s in data.social"
              :key="s.name"
              :href="s.href"
              :aria-label="s.name"
              class="btc-footer__social"
              target="_blank"
              rel="noopener noreferrer"
            >
              <svg
                width="17"
                height="17"
                viewBox="0 0 24 24"
                fill="currentColor"
                aria-hidden="true"
              >
                <path :d="icons[s.icon]"></path>
              </svg>
            </a>
          </div>
        </div>
      </div>

      <div
        v-if="siteLinks.length"
        class="btc-footer__col btc-footer__col--site"
      >
        <h4 class="btc-footer__label">This site</h4>
        <a
          v-for="l in siteLinks"
          :key="l.label"
          :href="l.href"
          class="btc-footer__link"
          >{{ l.label }}</a
        >
      </div>
      <div class="btc-footer__col btc-footer__col--services">
        <h4 class="btc-footer__label">Services</h4>
        <a
          v-for="l in data.services"
          :key="l.label"
          :href="l.href"
          class="btc-footer__link"
          >{{ l.label }}</a
        >
      </div>
      <div class="btc-footer__pair">
        <div class="btc-footer__col">
          <h4 class="btc-footer__label">Products</h4>
          <a
            v-for="l in data.products"
            :key="l.label"
            :href="l.href"
            class="btc-footer__link"
            >{{ l.label }}</a
          >
        </div>
        <div class="btc-footer__col">
          <h4 class="btc-footer__label">Resources</h4>
          <a
            v-for="l in data.resources"
            :key="l.label"
            :href="l.href"
            class="btc-footer__link"
            >{{ l.label }}</a
          >
        </div>
      </div>

      <div class="btc-footer__badge-row btc-footer__mobile">
        <img
          src="/images/salesforcePartnerBadgeHorizontal.png"
          alt="Salesforce Partner"
          class="btc-footer__badge"
        />
        <div class="btc-footer__socials">
          <a
            v-for="s in data.social"
            :key="s.name"
            :href="s.href"
            :aria-label="s.name"
            class="btc-footer__social"
            target="_blank"
            rel="noopener noreferrer"
          >
            <svg
              width="20"
              height="20"
              viewBox="0 0 24 24"
              fill="currentColor"
              aria-hidden="true"
            >
              <path :d="icons[s.icon]"></path>
            </svg>
          </a>
        </div>
      </div>
    </div>

    <div class="btc-footer__legal">
      <div class="btc-footer__legal-inner">
        <div class="btc-footer__legal-company">
          <span>{{ data.company.name }}</span
          ><span class="btc-footer__dot">·</span>
          <span>{{ data.company.nip }}</span
          ><span class="btc-footer__dot">·</span>
          <span>{{ data.company.address }}</span
          ><span class="btc-footer__dot">·</span>
          <a
            :href="'mailto:' + data.company.email"
            class="btc-footer__legal-link btc-footer__email"
            >{{ data.company.email }}</a
          >
        </div>
        <div class="btc-footer__legal-links">
          <a :href="data.legal.privacyPolicy" class="btc-footer__legal-link"
            >Privacy Policy</a
          ><span class="btc-footer__dot">·</span>
          <a :href="data.legal.mainSite" class="btc-footer__legal-link"
            >beyondthecloud.dev</a
          >
        </div>
        <div class="btc-footer__copy">© {{ year }} Beyond The Cloud</div>
      </div>
    </div>
  </footer>
</template>

<script setup>
import { computed } from "vue";
import { footerData, contextLinks } from "../footer-data.js";

const props = defineProps({
  context: { type: String, default: "trigger-lib" },
});

const data = footerData;
const year = new Date().getFullYear();
const siteLinks = computed(() => contextLinks[props.context] || []);
const icons = {
  linkedin:
    "M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z",
  github:
    "M12 0C5.374 0 0 5.373 0 12c0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23A11.509 11.509 0 0112 5.803c1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576C20.566 21.797 24 17.3 24 12c0-6.627-5.373-12-12-12z",
  youtube:
    "M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z",
};
</script>

<style scoped>
.btc-footer {
  --f-bg: #2c2c2c;
  --f-strip: #333333;
  --f-fg: #f5f5f5;
  --f-text: #c7c7c7;
  --f-muted: #a3a3a3;
  --f-label: #a3a3a3;
  --f-border: rgba(255, 255, 255, 0.1);
  --f-hover: rgba(255, 255, 255, 0.06);
  --f-link: #80d8fd;
  --f-accent: #007db0;
  --f-icon-bg: rgba(255, 255, 255, 0.07);
  --f-icon: #c7c7c7;
  --f-tint: rgba(128, 216, 253, 0.1);
  --f-tint-border: rgba(128, 216, 253, 0.55);
  --f-tile-m: rgba(255, 255, 255, 0.035);
  --f-logo-fx: none;
  width: 100%;
  margin-top: 64px;
  box-sizing: border-box;
  background: var(--f-bg);
  color: var(--f-text);
  font-family: inherit;
  -webkit-font-smoothing: antialiased;
}
.btc-footer a {
  text-decoration: none;
  transition:
    color 0.15s ease,
    background-color 0.15s ease;
}
.btc-footer__label {
  margin: 0 0 14px;
  font-size: 11px;
  line-height: 16px;
  font-weight: 700;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--f-label);
}
.btc-footer__strip {
  background: var(--f-strip);
  border-top: 1px solid var(--f-border);
  border-bottom: 1px solid var(--f-border);
}
.btc-footer__strip-inner {
  max-width: 1280px;
  margin: 0 auto;
  padding: 24px 24px;
  display: grid;
  grid-template-columns: 168px minmax(0, 1fr);
  align-items: center;
  gap: 20px;
}
.btc-footer__os .btc-footer__label {
  margin-bottom: 8px;
}
.btc-footer__parent {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 17px;
  line-height: 24px;
  font-weight: 800;
  color: var(--f-fg);
}
.btc-footer__parent:hover {
  color: var(--f-link);
}
.btc-footer__parent-logo {
  width: 28px;
  height: 28px;
  object-fit: contain;
  display: block;
  filter: var(--f-logo-fx);
}
.btc-footer__tiles {
  min-width: 0;
  display: grid;
  grid-template-columns: repeat(auto-fill, 100px);
  justify-content: start;
  gap: 6px;
}
.btc-footer__tile {
  height: 64px;
  border-radius: 8px;
  border: 1px solid var(--f-border);
  background: transparent;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 6px;
  padding: 0 4px;
  box-sizing: border-box;
  min-width: 0;
}
.btc-footer__tile:hover {
  background: var(--f-hover);
}
.btc-footer__tile.is-current {
  background: var(--f-tint);
  border-color: var(--f-tint-border);
}
.btc-footer__tile-logo {
  width: 22px;
  height: 22px;
  object-fit: contain;
  display: block;
  filter: var(--f-logo-fx);
}
.btc-footer__tile-name {
  font-size: 12px;
  line-height: 16px;
  font-weight: 700;
  color: var(--f-text);
  white-space: nowrap;
}
.btc-footer__tile.is-current .btc-footer__tile-name {
  color: var(--f-link);
}
.btc-footer__body {
  max-width: 1280px;
  margin: 0 auto;
  padding: 36px 24px;
  display: grid;
  grid-template-columns: 360px repeat(3, minmax(0, 1fr));
  gap: 40px;
}
.btc-footer__body:has(.btc-footer__col--site) {
  grid-template-columns: 360px repeat(4, minmax(0, 1fr));
}
.btc-footer__pair {
  display: contents;
}
.btc-footer__brand {
  display: flex;
  align-items: center;
  gap: 14px;
}
.btc-footer__logo {
  height: 36px;
  width: auto;
  display: block;
}
.btc-footer__logo--light {
  display: none;
}
.btc-footer__tagline {
  font-size: 16px;
  line-height: 20px;
  font-weight: 700;
  color: var(--f-fg);
  max-width: 130px;
}
.btc-footer__description {
  margin: 14px 0 0;
  font-size: 14px;
  line-height: 22px;
  color: var(--f-text);
  max-width: 330px;
}
.btc-footer__badge-row {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-top: 18px;
}
.btc-footer__badge {
  height: 36px;
  width: auto;
  display: block;
}
.btc-footer__socials {
  display: flex;
  gap: 4px;
}
.btc-footer__social {
  width: 36px;
  height: 36px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--f-icon-bg);
  color: var(--f-icon);
}
.btc-footer__social:hover {
  background: var(--f-accent);
  color: #ffffff;
}
.btc-footer__col {
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.btc-footer__col .btc-footer__label {
  margin-bottom: 4px;
}
.btc-footer__link {
  font-size: 14px;
  line-height: 20px;
  color: var(--f-text);
}
.btc-footer__link:hover {
  color: var(--f-link);
}
.btc-footer__mobile {
  display: none;
}
.btc-footer__legal {
  border-top: 1px solid var(--f-border);
}
.btc-footer__legal-inner {
  max-width: 1280px;
  margin: 0 auto;
  padding: 18px 24px 22px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 24px;
  font-size: 12.5px;
  line-height: 20px;
  color: var(--f-muted);
}
.btc-footer__legal-company {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 10px;
}
.btc-footer__legal-links {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-left: auto;
}
.btc-footer__copy {
  white-space: nowrap;
}
.btc-footer__legal-link {
  color: var(--f-muted);
}
.btc-footer__legal-link:hover {
  color: var(--f-link);
}

@media (max-width: 1100px) {
  .btc-footer__strip-inner {
    grid-template-columns: 1fr;
    gap: 16px;
  }
  .btc-footer__body,
  .btc-footer__body:has(.btc-footer__col--site) {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
  .btc-footer__company {
    grid-column: 1 / -1;
  }
}

@media (max-width: 767px) {
  .btc-footer {
    margin-top: 48px;
  }
  .btc-footer__strip-inner {
    padding: 24px 20px 16px;
    gap: 0;
  }
  .btc-footer__os .btc-footer__label {
    margin-bottom: 4px;
  }
  .btc-footer__os {
    display: contents;
  }
  .btc-footer__os .btc-footer__label {
    order: 1;
  }
  .btc-footer__parent {
    order: 2;
  }
  .btc-footer__tiles {
    order: 3;
  }
  .btc-footer__parent {
    min-height: 44px;
  }
  .btc-footer__parent-logo {
    width: 26px;
    height: 26px;
  }
  .btc-footer__tiles {
    grid-template-columns: repeat(3, minmax(0, 1fr));
    gap: 8px;
    margin-top: 10px;
  }
  .btc-footer__tile {
    height: 60px;
    gap: 5px;
    background: var(--f-tile-m);
  }
  .btc-footer__tile.is-current {
    background: var(--f-tint);
  }
  .btc-footer__tile-logo {
    width: 20px;
    height: 20px;
  }
  .btc-footer__body,
  .btc-footer__body:has(.btc-footer__col--site) {
    display: block;
    padding: 28px 20px 0;
  }
  .btc-footer__logo {
    height: 34px;
  }
  .btc-footer__description {
    margin-top: 12px;
    font-size: 15px;
    max-width: none;
  }
  .btc-footer__desktop {
    display: none;
  }
  .btc-footer__mobile {
    display: flex;
    justify-content: space-between;
    margin-top: 24px;
  }
  .btc-footer__badge {
    height: 44px;
  }
  .btc-footer__social {
    width: 44px;
    height: 44px;
  }
  .btc-footer__col {
    gap: 0;
    margin-top: 20px;
  }
  .btc-footer__col--site {
    margin-top: 24px;
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    column-gap: 16px;
  }
  .btc-footer__col--site .btc-footer__label {
    grid-column: 1 / -1;
  }
  .btc-footer__pair {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    column-gap: 16px;
  }
  .btc-footer__link {
    display: flex;
    align-items: center;
    min-height: 44px;
    font-size: 15px;
  }
  .btc-footer__legal {
    margin-top: 28px;
  }
  .btc-footer__legal-inner {
    display: block;
    padding: 16px 20px 28px;
  }
  .btc-footer__legal-company {
    display: block;
  }
  .btc-footer__legal-company > span {
    display: block;
  }
  .btc-footer__legal-company > .btc-footer__dot,
  .btc-footer__legal-links > .btc-footer__dot {
    display: none;
  }
  .btc-footer__email {
    display: flex;
    align-items: center;
    min-height: 44px;
    text-decoration: underline;
    text-underline-offset: 3px;
  }
  .btc-footer__legal-links {
    margin-left: 0;
    gap: 24px;
  }
  .btc-footer__legal-links .btc-footer__legal-link {
    display: flex;
    align-items: center;
    min-height: 44px;
    font-size: 14px;
    color: var(--f-text);
  }
  .btc-footer__copy {
    margin-top: 4px;
  }
}
</style>

<style>
html:not(.dark) .btc-footer {
  --f-bg: #f9f9f9;
  --f-strip: #ffffff;
  --f-fg: #1f1f1f;
  --f-text: #424242;
  --f-muted: #616161;
  --f-label: #616161;
  --f-border: #e2e2e2;
  --f-hover: rgba(0, 0, 0, 0.04);
  --f-link: #0073a3;
  --f-accent: #007db0;
  --f-icon-bg: #ececec;
  --f-icon: #424242;
  --f-tint: rgba(0, 146, 200, 0.07);
  --f-tint-border: rgba(0, 115, 163, 0.5);
  --f-tile-m: #f9f9f9;
  --f-logo-fx: drop-shadow(0 0 0.6px rgba(0, 0, 0, 0.7))
    drop-shadow(0 1px 1.5px rgba(0, 0, 0, 0.35));
}
html:not(.dark) .btc-footer .btc-footer__logo--dark {
  display: none;
}
html:not(.dark) .btc-footer .btc-footer__logo--light {
  display: block;
}
/* Docs pages: keep the footer clear of the fixed VitePress sidebar */
@media (min-width: 960px) {
  .VPContent.has-sidebar ~ .btc-footer {
    padding-left: var(--vp-sidebar-width);
  }
}
@media (min-width: 1440px) {
  .VPContent.has-sidebar ~ .btc-footer {
    padding-left: calc(
      (100vw - var(--vp-layout-max-width)) / 2 + var(--vp-sidebar-width)
    );
  }
}
</style>
