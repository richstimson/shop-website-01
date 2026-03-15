# Lumen Shop

Minimal shop front-end built with Next.js (App Router), Tailwind CSS, Apollo Client, and an optional Supabase backend. The UI uses mock data today and is ready to wire up to GraphQL or Supabase later.

## Public URL

Production site: `https://shop-website-01.pages.dev`

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
3. Set the framework preset to Next.js.
4. Build command: `npm run pages:build`
5. Build output directory: `.vercel/output/static`
6. Add the environment variables from `.env.local` in the Pages dashboard.
7. Current Cloudflare Pages URL: `https://shop-website-01.pages.dev`

## How to update the live site

1. Edit the relevant files in this repo.
2. Run the app locally with `npm run dev` if you want to preview the change before publishing.
3. Commit the changes to `main`.
4. Push `main` to GitHub.
5. Wait for Cloudflare Pages to detect the new commit and start a deployment.
6. Open the Pages project in Cloudflare if you want to watch the build logs.
7. After the deployment succeeds, verify the live site at `https://shop-website-01.pages.dev`.
8. If the live site does not change, check the latest deployment status in Cloudflare Pages and redeploy the latest commit if needed.

### Notes

- This workflow assumes Cloudflare Pages is connected to the GitHub repo and auto-deploys on push.
- If you add new environment variables, update them in the Cloudflare Pages dashboard before expecting the live site to use them.

## Optional Supabase backend

When you’re ready to connect Supabase, add your project URL and anon key to `.env.local`. The client is initialized in `src/lib/supabaseClient.ts`, so you can swap mock data calls for Supabase queries as needed.
