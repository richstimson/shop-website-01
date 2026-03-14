Below is a ready-to-copy set of English prompts you can give to ChatGPT 5.2 Codex, plus where you must click/do things manually (GitHub + Cloudflare). I've kept them concise and sequential so you can run them one-by-one.

## Prompt Set (use in order)

### Prompt 1 - Scaffold + base setup

"Create a new Next.js app in the current empty folder using App Router, TypeScript, Tailwind, ESLint, and src dir. Use npm. Then install Apollo Client, GraphQL, Supabase client, and rxjs. Pin versions to Next 15.5.2, React 18.2.0, ReactDOM 18.2.0, and install @cloudflare/next-on-pages plus React 18 types. Add a pages:build script that runs next build && npx @cloudflare/next-on-pages. Ensure package.json reflects these versions exactly."

### Prompt 2 - Core files

"Create the following files:

- apolloClient.ts
- supabaseClient.ts
- providers.tsx

Wrap the app in Providers in layout.tsx.
Use ApolloProvider from @apollo/client/react."

### Prompt 3 - Data + pages

"Create products.ts with 6 football shirt items (id, name, description, price, image path, category, inStock).
Then create pages:

- page.tsx (bright theme homepage)
- page.tsx (grid of product cards with image, price, status)
- page.tsx (detail view with image, price, buttons)

Use next/image for images and generateStaticParams for detail routes."

### Prompt 4 - Bright theme

"Update all pages to a brighter color theme (light slate background, amber/sand accents, white cards, soft shadows). Keep the same layout structure."

### Prompt 5 - Images

"Create images and expect these image filenames:

- shirt-dundalk-2019.jpg
- shirt-dinamo-minsk-2011.jpg
- shirt-atl-parana.png
- shirt-columbus-eagles.png
- shirt-municipal-2008.jpg
- shirt-flamengo-2025.png

Update the product data to reference those exact files."

### Prompt 6 - Cloudflare Pages support

"Update README with Cloudflare Pages deployment instructions:

- Build command: npm run pages:build
- Output directory: static
- Compatibility flag: nodejs_compat

Note that Next is pinned to 15.5.2 for Cloudflare compatibility."

### Prompt 7 - Fix build issues

"If Next build fails due to Apollo + rxjs, ensure rxjs is installed and retry.
If route param typing fails, make the [id] page params type Promise<{ id: string }> and await params."

### Prompt 8 - GitHub push

"Initialize git, commit everything, add remote https://github.com/richstimson/shop-website-01.git, and push main."

## Manual steps you must do yourself

### GitHub

1. Create empty repo: richstimson/shop-website-01
2. Don't add README/.gitignore from GitHub
3. Let Codex push after it commits

### Cloudflare Pages

1. Go to Workers & Pages -> Create application -> Pages -> Git integration
2. Select richstimson/shop-website-01
3. Build settings:
   - Framework: Next.js
   - Build command: npm run pages:build
   - Output directory: .vercel/output/static
4. Add Compatibility Flag nodejs_compat (Production + Preview)
5. Redeploy

Below is a ready-to-copy set of English prompts you can give to ChatGPT 5.2 Codex, plus where you must click/do things manually (GitHub + Cloudflare). I've kept them concise and sequential so you can run them one-by-one.

## Prompt Set (use in order)

### Prompt 1 - Scaffold + base setup

"Create a new Next.js app in the current empty folder using App Router, TypeScript, Tailwind, ESLint, and src dir. Use npm. Then install Apollo Client, GraphQL, Supabase client, and rxjs. Pin versions to Next 15.5.2, React 18.2.0, ReactDOM 18.2.0, and install @cloudflare/next-on-pages plus React 18 types. Add a pages:build script that runs next build && npx @cloudflare/next-on-pages. Ensure package.json reflects these versions exactly."

### Prompt 2 - Core files

"Create the following files:

- apolloClient.ts
- supabaseClient.ts
- providers.tsx

Wrap the app in Providers in layout.tsx.
Use ApolloProvider from @apollo/client/react."

### Prompt 3 - Data + pages

"Create products.ts with 6 football shirt items (id, name, description, price, image path, category, inStock).
Then create pages:

- page.tsx (bright theme homepage)
- page.tsx (grid of product cards with image, price, status)
- page.tsx (detail view with image, price, buttons)

Use next/image for images and generateStaticParams for detail routes."

### Prompt 4 - Bright theme

"Update all pages to a brighter color theme (light slate background, amber/sand accents, white cards, soft shadows). Keep the same layout structure."

### Prompt 5 - Images

"Create images and expect these image filenames:

- shirt-dundalk-2019.jpg
- shirt-dinamo-minsk-2011.jpg
- shirt-atl-parana.png
- shirt-columbus-eagles.png
- shirt-municipal-2008.jpg
- shirt-flamengo-2025.png

Update the product data to reference those exact files."

### Prompt 6 - Cloudflare Pages support

"Update README with Cloudflare Pages deployment instructions:

- Build command: npm run pages:build
- Output directory: static
- Compatibility flag: nodejs_compat

Note that Next is pinned to 15.5.2 for Cloudflare compatibility."

### Prompt 7 - Fix build issues

"If Next build fails due to Apollo + rxjs, ensure rxjs is installed and retry.
If route param typing fails, make the [id] page params type Promise<{ id: string }> and await params."

### Prompt 8 - GitHub push

"Initialize git, commit everything, add remote https://github.com/richstimson/shop-website-01.git, and push main."

## Manual steps you must do yourself

### GitHub

1. Create empty repo: richstimson/shop-website-01
2. Don't add README/.gitignore from GitHub
3. Let Codex push after it commits

### Cloudflare Pages

1. Go to Workers & Pages -> Create application -> Pages -> Git integration
2. Select richstimson/shop-website-01
3. Build settings:
   - Framework: Next.js
   - Build command: npm run pages:build
   - Output directory: .vercel/output/static
4. Add Compatibility Flag nodejs_compat (Production + Preview)
5. Redeploy
