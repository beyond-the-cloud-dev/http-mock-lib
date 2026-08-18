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

<style scoped>
.version-banner {
  position: relative;
  z-index: var(--vp-z-index-banner);
  padding: 8px 24px;
  background-color: var(--vp-c-warning-soft);
  color: var(--vp-c-text-1);
  font-size: 14px;
  text-align: center;
  line-height: 20px;
}

.version-banner a {
  color: var(--vp-c-brand-1);
  font-weight: 600;
  text-decoration: underline;
}
</style>
