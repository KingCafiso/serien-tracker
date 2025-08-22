
/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    remotePatterns: [
      { protocol: 'https', hostname: 'image.tmdb.org' },
      { protocol: 'https', hostname: 'm.media-amazon.com' },
      { protocol: 'https', hostname: 'img.omdbapi.com' },
      { protocol: 'https', hostname: 'i.ytimg.com' }
    ]
  }
};
module.exports = nextConfig;
