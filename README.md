# Lumen Shop

Minimal shop front-end built with Next.js (App Router), Tailwind CSS, Apollo Client, and an optional Supabase backend. The UI uses mock data today and is ready to wire up to GraphQL or Supabase later.

## What’s inside

- Home page: `src/app/page.tsx`
- Product list: `src/app/products/page.tsx`
- Product detail: `src/app/products/[id]/page.tsx`
- Mock data: `src/data/products.ts`
- Apollo client: `src/lib/apolloClient.ts`
- Supabase client (optional): `src/lib/supabaseClient.ts`

## Local development

```bash
npm run dev
```

Open `http://localhost:3000` to view the app.

## Environment variables

Create a `.env.local` file if you want to configure APIs.

```bash
NEXT_PUBLIC_GRAPHQL_ENDPOINT=https://your-graphql-endpoint
NEXT_PUBLIC_SUPABASE_URL=https://your-supabase-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

If you skip Supabase values, the app will continue to run with mock data.

## Cloudflare Pages deployment

1. Push this repo to your Git provider.
2. Create a new Cloudflare Pages project and connect the repo.
3. Set the framework preset to Next.js (or use the defaults).
4. Build command: `npm run build`
5. Build output directory: `.next`
6. Add the environment variables from `.env.local` in the Pages dashboard.

## Optional Supabase backend

When you’re ready to connect Supabase, add your project URL and anon key to `.env.local`. The client is initialized in `src/lib/supabaseClient.ts`, so you can swap mock data calls for Supabase queries as needed.
