<script setup>
import { computed } from 'vue'
import { useRoute } from 'vitepress'

const route = useRoute()

const version = computed(() => {
  const match = route.path.match(/^\/(\d+\.\d+\.\d+)\//)
  return match ? match[1] : null
})
</script>

<template>
  <div v-if="version" class="version-banner">
    You are reading the documentation for
    <strong>v{{ version }}</strong>.
    <a href="/">Go to the latest version →</a>
  </div>
</template>

<!--
  Unscoped: the default theme offsets the fixed navbar, sidebar, hero and content
  by --vp-layout-top-height. Without it the banner sits underneath the navbar.
-->
<style>
:root:has(.version-banner) {
  --vp-layout-top-height: 40px;
}

@media (max-width: 640px) {
  :root:has(.version-banner) {
    --vp-layout-top-height: 60px;
  }
}
</style>

<style scoped>
.version-banner {
  position: fixed;
  top: 0;
  left: 0;
  z-index: var(--vp-z-index-layout-top);
  box-sizing: border-box;
  width: 100%;
  height: var(--vp-layout-top-height, 40px);
  padding: 8px 24px;
  /* Opaque base + tint: the banner is fixed, so a translucent fill would
     let scrolling content show through it. */
  background-color: var(--vp-c-bg);
  background-image: linear-gradient(var(--vp-c-yellow-soft), var(--vp-c-yellow-soft));
  border-bottom: 1px solid var(--vp-c-divider);
  color: var(--vp-c-text-1);
  font-size: 14px;
  line-height: 24px;
  text-align: center;
}

.version-banner a {
  color: var(--vp-c-brand-1);
  font-weight: 600;
  text-decoration: underline;
  text-underline-offset: 2px;
}
</style>
