import { createMDX } from 'fumadocs-mdx/next';

const withMDX = createMDX();

/** @type {import('next').NextConfig} */
const config = {
  reactStrictMode: true,
  async rewrites() {
    return {
      beforeFiles: [
        {
          source: '/docs/:path*.md',
          destination: '/api/llm/:path*',
        },
      ],
      afterFiles: [],
      fallback: [],
    };
  },
  async redirects() {
    return [
      {
        source: '/docs/:category(data|feedback|form|foundation|layout|navigation|overlay|tile)/:slug*',
        destination: '/docs/widgets/:category/:slug*',
        permanent: true,
      },
    ];
  },
};

export default withMDX(config);
