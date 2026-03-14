#!/usr/bin/env bash
set -euo pipefail

if [ "$(ls -A .)" ]; then
  echo "This script expects an empty folder. Please run it in a clean directory." >&2
  exit 1
fi

# 1) Scaffold Next.js
npx create-next-app@latest . --ts --tailwind --eslint --app --src-dir --import-alias "@/*" --use-npm

# 2) Pin versions for Cloudflare Pages compatibility
npm install next@15.5.2 react@18.2.0 react-dom@18.2.0 --save-exact

# 3) Dependencies
npm install @apollo/client graphql @supabase/supabase-js rxjs
npm install -D @types/react@18.2.66 @types/react-dom@18.2.22 @cloudflare/next-on-pages --legacy-peer-deps

# 4) Add pages:build script
node -e "const fs=require('fs');const p='package.json';const pkg=JSON.parse(fs.readFileSync(p,'utf8'));pkg.scripts=pkg.scripts||{};pkg.scripts['pages:build']='next build && npx @cloudflare/next-on-pages';fs.writeFileSync(p, JSON.stringify(pkg,null,2));"

# 5) App providers
mkdir -p src/lib src/data src/app/products/[id]

cat > src/lib/apolloClient.ts <<'EOF'
import { ApolloClient, HttpLink, InMemoryCache } from "@apollo/client";

const GRAPHQL_ENDPOINT =
  process.env.NEXT_PUBLIC_GRAPHQL_ENDPOINT || "https://example.com/graphql";

export const apolloClient = new ApolloClient({
  link: new HttpLink({ uri: GRAPHQL_ENDPOINT }),
  cache: new InMemoryCache(),
});
EOF

cat > src/lib/supabaseClient.ts <<'EOF'
import { createClient } from "@supabase/supabase-js";

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || "";
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || "";

export const supabaseClient =
  supabaseUrl && supabaseAnonKey
    ? createClient(supabaseUrl, supabaseAnonKey)
    : null;
EOF

cat > src/app/providers.tsx <<'EOF'
"use client";

import type { ReactNode } from "react";
import { ApolloProvider } from "@apollo/client/react";
import { apolloClient } from "@/lib/apolloClient";

type ProvidersProps = {
  children: ReactNode;
};

export function Providers({ children }: ProvidersProps) {
  return <ApolloProvider client={apolloClient}>{children}</ApolloProvider>;
}
EOF

cat > src/app/layout.tsx <<'EOF'
import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import { Providers } from "@/app/providers";
import "./globals.css";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "Lumen Shop",
  description: "Football shirt shop demo",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className={`${geistSans.variable} ${geistMono.variable} antialiased`}>
        <Providers>{children}</Providers>
      </body>
    </html>
  );
}
EOF

# 6) Data
cat > src/data/products.ts <<'EOF'
export type Product = {
  id: string;
  name: string;
  description: string;
  price: number;
  image: string;
  category: string;
  inStock: boolean;
};

export const products: Product[] = [
  {
    id: "dundalk-third-2019",
    name: "Dundalk Third Kit 2019",
    description: "Bold dark kit with subtle patterning and bright crest.",
    price: 84,
    image: "/images/shirt-dundalk-2019.jpg",
    category: "Football shirts",
    inStock: true,
  },
  {
    id: "dinamo-minsk-2011",
    name: "Dinamo Minsk 2011 Kit",
    description: "Classic blue kit with clean panel detailing.",
    price: 79,
    image: "/images/shirt-dinamo-minsk-2011.jpg",
    category: "Football shirts",
    inStock: true,
  },
  {
    id: "atl-parana",
    name: "Atl. Parana 2022 Shirt",
    description: "High-contrast stripes with a modern collar shape.",
    price: 88,
    image: "/images/shirt-atl-parana.png",
    category: "Football shirts",
    inStock: true,
  },
  {
    id: "columbus-eagles",
    name: "Columbus Eagles FC Kit",
    description: "Home, away, and keeper variations in one showcase.",
    price: 92,
    image: "/images/shirt-columbus-eagles.png",
    category: "Football shirts",
    inStock: true,
  },
  {
    id: "municipal-2008",
    name: "Municipal 2008 Shirt",
    description: "Vintage red-and-blue kit with classic badge styling.",
    price: 74,
    image: "/images/shirt-municipal-2008.jpg",
    category: "Football shirts",
    inStock: false,
  },
  {
    id: "flamengo-2025",
    name: "Flamengo Pre-game 2025",
    description: "Lightweight training top for warm-ups and matchday.",
    price: 69,
    image: "/images/shirt-flamengo-2025.png",
    category: "Football shirts",
    inStock: true,
  },
];
EOF

# 7) Pages
cat > src/app/page.tsx <<'EOF'
import Link from "next/link";

export default function Home() {
  return (
    <div className="min-h-screen bg-slate-50 text-slate-900">
      <header className="mx-auto flex w-full max-w-6xl items-center justify-between px-6 py-10">
        <div className="flex items-center gap-3 text-lg font-semibold tracking-tight">
          <span className="rounded-full bg-amber-100 px-3 py-1 text-xs uppercase tracking-[0.2em] text-amber-700">
            Shop
          </span>
          Lumen
        </div>
        <nav className="flex items-center gap-6 text-sm text-slate-600">
          <Link className="hover:text-slate-900" href="/products">
            Products
          </Link>
          <span>Stories</span>
          <span>Contact</span>
        </nav>
      </header>

      <main className="mx-auto grid w-full max-w-6xl gap-12 px-6 pb-16">
        <section className="grid gap-8 rounded-3xl bg-gradient-to-br from-amber-100 via-orange-50 to-sky-100 p-10">
          <p className="text-sm uppercase tracking-[0.3em] text-amber-700">
            Modern home essentials
          </p>
          <h1 className="text-4xl font-semibold leading-tight text-slate-900 sm:text-5xl">
            Curated pieces that bring calm and clarity to your space.
          </h1>
          <p className="max-w-2xl text-base text-slate-600 sm:text-lg">
            Discover handcrafted lighting, textiles, and decor with a focus on
            sustainable materials and quiet luxury.
          </p>
          <div className="flex flex-col gap-4 sm:flex-row">
            <Link
              className="rounded-full bg-slate-900 px-6 py-3 text-sm font-semibold text-white"
              href="/products"
            >
              Browse the collection
            </Link>
            <button className="rounded-full border border-slate-300 px-6 py-3 text-sm text-slate-700">
              Meet the makers
            </button>
          </div>
        </section>

        <section className="grid gap-6 sm:grid-cols-3">
          {[
            {
              title: "Design-led pieces",
              copy: "Thoughtful silhouettes and timeless palettes.",
            },
            {
              title: "Small-batch craft",
              copy: "Every item made in limited, intentional runs.",
            },
            {
              title: "Ready to ship",
              copy: "Fast dispatch from our London studio.",
            },
          ].map((feature) => (
            <div
              key={feature.title}
              className="rounded-2xl border border-slate-200 bg-white p-6 shadow-sm"
            >
              <h3 className="text-lg font-semibold">{feature.title}</h3>
              <p className="mt-3 text-sm text-slate-600">{feature.copy}</p>
            </div>
          ))}
        </section>
      </main>
    </div>
  );
}
EOF

cat > src/app/products/page.tsx <<'EOF'
import Image from "next/image";
import Link from "next/link";
import { products } from "@/data/products";

export default function ProductsPage() {
  return (
    <div className="min-h-screen bg-slate-50 text-slate-900">
      <header className="mx-auto flex w-full max-w-6xl items-center justify-between px-6 py-10">
        <div className="text-lg font-semibold">Lumen</div>
        <Link className="text-sm text-slate-600 hover:text-slate-900" href="/">
          Back to home
        </Link>
      </header>

      <main className="mx-auto grid w-full max-w-6xl gap-6 px-6 pb-16">
        <div className="flex items-end justify-between">
          <div>
            <h1 className="text-3xl font-semibold">All products</h1>
            <p className="text-slate-600">
              Small-batch essentials designed for calm, modern living.
            </p>
          </div>
          <span className="text-sm text-slate-500">
            {products.length} items
          </span>
        </div>

        <section className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {products.map((product) => (
            <Link
              key={product.id}
              href={`/products/${product.id}`}
              className="group rounded-2xl border border-slate-200 bg-white p-5 shadow-sm transition hover:-translate-y-0.5 hover:border-slate-300 hover:shadow-md"
            >
              <div className="mb-4 overflow-hidden rounded-xl bg-slate-100">
                <Image
                  src={product.image}
                  alt={product.name}
                  width={560}
                  height={420}
                  className="h-40 w-full object-contain transition duration-300 group-hover:scale-105"
                />
              </div>
              <h2 className="text-lg font-semibold text-slate-900">
                {product.name}
              </h2>
              <p className="mt-2 text-sm text-slate-600">
                {product.description}
              </p>
              <div className="mt-4 flex items-center justify-between text-sm">
                <span className="font-semibold text-slate-900">
                  ${product.price}
                </span>
                <span
                  className={`rounded-full px-2 py-1 text-xs ${
                    product.inStock
                      ? "bg-emerald-100 text-emerald-700"
                      : "bg-rose-100 text-rose-700"
                  }`}
                >
                  {product.inStock ? "In stock" : "Back soon"}
                </span>
              </div>
            </Link>
          ))}
        </section>
      </main>
    </div>
  );
}
EOF

cat > src/app/products/[id]/page.tsx <<'EOF'
import Image from "next/image";
import Link from "next/link";
import { products } from "@/data/products";

type ProductPageProps = {
  params: Promise<{ id: string }>;
};

export function generateStaticParams() {
  return products.map((product) => ({ id: product.id }));
}

export default async function ProductPage({ params }: ProductPageProps) {
  const { id } = await params;
  const product = products.find((item) => item.id === id);

  if (!product) {
    return (
      <div className="min-h-screen bg-slate-50 text-slate-900">
        <main className="mx-auto flex w-full max-w-4xl flex-col gap-6 px-6 py-20">
          <p className="text-slate-600">Product not found.</p>
          <Link className="text-sm text-slate-900 underline" href="/products">
            Back to products
          </Link>
        </main>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-slate-50 text-slate-900">
      <header className="mx-auto flex w-full max-w-6xl items-center justify-between px-6 py-10">
        <Link className="text-sm text-slate-600 hover:text-slate-900" href="/products">
          Back to products
        </Link>
        <span className="text-sm text-slate-500">{product.category}</span>
      </header>

      <main className="mx-auto grid w-full max-w-6xl gap-10 px-6 pb-16 lg:grid-cols-[1.1fr_0.9fr]">
        <div className="flex min-h-[320px] items-center justify-center rounded-3xl bg-white p-6 shadow-sm">
          <Image
            src={product.image}
            alt={product.name}
            width={720}
            height={540}
            className="max-h-[360px] w-full object-contain"
          />
        </div>
        <div className="flex flex-col gap-6">
          <h1 className="text-3xl font-semibold text-slate-900 sm:text-4xl">
            {product.name}
          </h1>
          <p className="text-slate-600">{product.description}</p>
          <div className="flex items-center gap-4">
            <span className="text-2xl font-semibold text-slate-900">
              ${product.price}
            </span>
            <span
              className={`rounded-full px-3 py-1 text-xs ${
                product.inStock
                  ? "bg-emerald-100 text-emerald-700"
                  : "bg-rose-100 text-rose-700"
              }`}
            >
              {product.inStock ? "In stock" : "Back soon"}
            </span>
          </div>
          <div className="flex flex-col gap-3">
            <button className="rounded-full bg-slate-900 px-6 py-3 text-sm font-semibold text-white">
              Add to bag
            </button>
            <button className="rounded-full border border-slate-300 px-6 py-3 text-sm text-slate-700">
              Save for later
            </button>
          </div>
          <div className="rounded-2xl border border-slate-200 bg-white p-4 text-sm text-slate-600 shadow-sm">
            Ships in 3-5 days • Free returns within 30 days
          </div>
        </div>
      </main>
    </div>
  );
}
EOF

# 8) Images
mkdir -p public/images
curl -L -o public/images/shirt-dundalk-2019.jpg https://upload.wikimedia.org/wikipedia/commons/0/07/Dundalk_Third_Kit_2019.jpg
curl -L -o public/images/shirt-dinamo-minsk-2011.jpg https://upload.wikimedia.org/wikipedia/commons/0/0f/Dinamo_Minsk_Kit_2011.jpg
curl -L -o public/images/shirt-atl-parana.png https://upload.wikimedia.org/wikipedia/commons/2/2e/Equipaci%C3%B3n_Atl_Parana.png
curl -L -o public/images/shirt-columbus-eagles.png https://upload.wikimedia.org/wikipedia/commons/5/5f/Columbus_Eagles_FC_kit.png
curl -L -o public/images/shirt-municipal-2008.jpg https://upload.wikimedia.org/wikipedia/commons/a/ae/CAMISETA_MUNICIPAL_2008.jpg
curl -L -o public/images/shirt-flamengo-2025.png https://upload.wikimedia.org/wikipedia/commons/6/6f/Flamengopregame2025.png

# 9) README
cat > README.md <<'EOF'
# Lumen Shop

Minimal shop front-end built with Next.js (App Router), Tailwind CSS, Apollo Client, and an optional Supabase backend. The UI uses mock data today and is ready to wire up to GraphQL or Supabase later.

## Local development

npm run dev

## Cloudflare Pages deployment

- Framework preset: Next.js
- Build command: npm run pages:build
- Build output directory: .vercel/output/static
- Compatibility flag: nodejs_compat

## Environment variables (optional)

NEXT_PUBLIC_GRAPHQL_ENDPOINT=https://your-graphql-endpoint
NEXT_PUBLIC_SUPABASE_URL=https://your-supabase-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
EOF

echo "✅ Done. Run: npm run dev"
