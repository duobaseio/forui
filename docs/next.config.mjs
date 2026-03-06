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
};

export default withMDX(config);
