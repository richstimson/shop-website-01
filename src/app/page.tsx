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
