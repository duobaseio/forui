import { defineI18n } from 'fumadocs-core/i18n';
import { defineI18nUI } from 'fumadocs-ui/i18n';

export const i18n = defineI18n({
  defaultLanguage: 'en',
  languages: ['en', 'zh', 'de'],
});

export const i18nUI = defineI18nUI(i18n, {
  translations: {
    en: { displayName: 'English' },
    zh: {
      displayName: '中文',
      search: '搜索文档',
      searchNoResult: '没有结果',
      toc: '本页内容',
      tocNoHeadings: '没有标题',
      lastUpdate: '最后更新',
      chooseLanguage: '选择语言',
      nextPage: '下一页',
      previousPage: '上一页',
      chooseTheme: '主题',
      editOnGithub: '在 GitHub 上编辑',
    },
    de: {
      displayName: 'Deutsch',
      search: 'Suchen…',
      searchNoResult: 'Keine Ergebnisse',
      toc: 'Auf dieser Seite',
      tocNoHeadings: 'Keine Überschriften',
      lastUpdate: 'Zuletzt aktualisiert',
      chooseLanguage: 'Sprache wählen',
      nextPage: 'Nächste Seite',
      previousPage: 'Vorherige Seite',
      chooseTheme: 'Theme',
      editOnGithub: 'Auf GitHub bearbeiten',
    },
  },
});

export const translations = {
  en: {
    nav: { docs: 'Documentation', enterprise: 'Enterprise', home: 'Home' },
    footer: { builtBy: 'Built by', fromSingapore: 'from Singapore.' },
    docs: { apiReference: 'API Reference' },
    home: {
      title: 'Beautifully designed minimalistic Flutter widgets',
      subtitle:
        'A flutter platform-agnostic UI library for developers seeking consistent and elegant UIs across all devices. Fully customizable, free, and open source.',
      getStarted: 'Get Started',
    },
    enterprise: {
      metadataTitle: 'Enterprise',
      heroTitle: 'Enterprise Support',
      heroSubtitle:
        'Get hands-on support from the team behind Forui. We work alongside you to solve complex challenges and ship exceptional Flutter apps faster.',
      getInTouch: 'Get in Touch',
      learnMore: 'Learn More',
      servicesTitle: 'Accelerate Your Development',
      services: {
        development: {
          title: 'Development',
          description: 'Expert assistance with challenging Flutter project goals.',
        },
        guidance: {
          title: 'Technical Guidance',
          description: 'Technology optimization and reliability for your Flutter apps.',
        },
        migration: {
          title: 'Migration Assistance',
          description: 'Comprehensive upgrade support for Forui versions.',
        },
        review: {
          title: 'Code Reviews',
          description: 'In-depth reviews to prevent bugs and enforce best practices.',
        },
        lts: {
          title: 'Long-Term Support (LTS)',
          description: 'Priority fixes, upgrades, and troubleshooting.',
        },
        training: {
          title: 'Team Training',
          description: 'Expert-led workshops for skill development.',
        },
      },
      ctaTitle: 'Ready to Get Started?',
      ctaSubtitle: 'Contact us to learn more about how we can help your team succeed with Flutter and Forui.',
      contactUs: 'Contact Us',
    },
  },
  zh: {
    nav: { docs: '文档', enterprise: '企业', home: '主页' },
    footer: { builtBy: '由', fromSingapore: '于新加坡构建。' },
    docs: { apiReference: 'API 参考' },
    home: {
      title: '精美极简的 Flutter 组件库',
      subtitle:
        '一个为 Flutter 设计的平台无关 UI 库，为追求一致与优雅界面的开发者打造。完全可定制，免费，开源。',
      getStarted: '快速开始',
    },
    enterprise: {
      metadataTitle: '企业服务',
      heroTitle: '企业支持',
      heroSubtitle:
        '由 Forui 背后的团队为您提供贴身支持。我们与您并肩协作，解决复杂挑战，更快交付出色的 Flutter 应用。',
      getInTouch: '联系我们',
      learnMore: '了解更多',
      servicesTitle: '加速您的开发',
      services: {
        development: {
          title: '开发服务',
          description: '为具有挑战性的 Flutter 项目目标提供专家协助。',
        },
        guidance: {
          title: '技术指导',
          description: '为您的 Flutter 应用提供技术优化与可靠性指导。',
        },
        migration: {
          title: '迁移协助',
          description: '为 Forui 版本升级提供全面的支持。',
        },
        review: {
          title: '代码审查',
          description: '深入审查代码以预防缺陷并推行最佳实践。',
        },
        lts: {
          title: '长期支持 (LTS)',
          description: '优先修复、升级与故障排查。',
        },
        training: {
          title: '团队培训',
          description: '由专家主导的工作坊，助力团队技能成长。',
        },
      },
      ctaTitle: '准备好开始了吗？',
      ctaSubtitle: '联系我们，了解我们如何帮助您的团队在 Flutter 和 Forui 上取得成功。',
      contactUs: '联系我们',
    },
  },
  de: {
    nav: { docs: 'Dokumentation', enterprise: 'Enterprise', home: 'Startseite' },
    footer: { builtBy: 'Entwickelt von', fromSingapore: 'aus Singapur.' },
    docs: { apiReference: 'API-Referenz' },
    home: {
      title: 'Wunderschön gestaltete, minimalistische Flutter-Widgets',
      subtitle:
        'Eine plattformunabhängige UI-Bibliothek für Flutter-Entwickler, die konsistente und elegante Oberflächen auf allen Geräten suchen. Vollständig anpassbar, kostenlos und Open Source.',
      getStarted: 'Loslegen',
    },
    enterprise: {
      metadataTitle: 'Enterprise',
      heroTitle: 'Enterprise-Support',
      heroSubtitle:
        'Erhalte direkten Support vom Team hinter Forui. Wir arbeiten Hand in Hand mit dir, lösen komplexe Herausforderungen und liefern herausragende Flutter-Apps schneller aus.',
      getInTouch: 'Kontakt aufnehmen',
      learnMore: 'Mehr erfahren',
      servicesTitle: 'Beschleunige deine Entwicklung',
      services: {
        development: {
          title: 'Entwicklung',
          description: 'Expertenunterstützung für anspruchsvolle Flutter-Projektziele.',
        },
        guidance: {
          title: 'Technische Beratung',
          description: 'Optimierung und Zuverlässigkeit für deine Flutter-Apps.',
        },
        migration: {
          title: 'Migrationshilfe',
          description: 'Umfassende Unterstützung beim Upgrade auf neue Forui-Versionen.',
        },
        review: {
          title: 'Code-Reviews',
          description: 'Tiefgehende Reviews zur Fehlervermeidung und Durchsetzung bewährter Praktiken.',
        },
        lts: {
          title: 'Langzeitsupport (LTS)',
          description: 'Priorisierte Fixes, Upgrades und Fehlerbehebung.',
        },
        training: {
          title: 'Team-Schulungen',
          description: 'Workshops unter Leitung von Expert:innen zur Weiterentwicklung deiner Skills.',
        },
      },
      ctaTitle: 'Bereit loszulegen?',
      ctaSubtitle: 'Sprich mit uns und erfahre, wie wir deinem Team mit Flutter und Forui zum Erfolg verhelfen.',
      contactUs: 'Kontakt aufnehmen',
    },
  },
} as const;

export type Lang = keyof typeof translations;

export function t(lang: string): (typeof translations)[Lang] {
  return (lang as Lang) in translations ? translations[lang as Lang] : translations.en;
}
