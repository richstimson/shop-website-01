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
