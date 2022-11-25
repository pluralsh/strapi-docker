export default ({ env }) => ([
  'strapi::errors',
  'strapi::security',
  {
    name: 'strapi::security',
    config: {
      contentSecurityPolicy: {
        useDefaults: true,
        directives: {
          'connect-src': ["'self'", 'https:'],
          'img-src': [
            "'self'",
            'data:',
            'blob:',
            env('S3_URL'), // yourBucketName.s3.yourRegion.amazonaws.com, or if path style access is enabled use s3.yourRegion.amazonaws.com
          ],
          'media-src': [
            "'self'",
            'data:',
            'blob:',
            env('S3_URL'),  // yourBucketName.s3.yourRegion.amazonaws.com, or if path style access is enabled use s3.yourRegion.amazonaws.com
          ],
          upgradeInsecureRequests: null,
        },
      },
    },
  },
  'strapi::cors',
  'strapi::poweredBy',
  'strapi::logger',
  'strapi::query',
  'strapi::body',
  'strapi::session',
  'strapi::favicon',
  'strapi::public',
]);
