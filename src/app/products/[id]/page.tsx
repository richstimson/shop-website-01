import Image from "next/image";
import Link from "next/link";
import { products } from "@/data/products";

type ProductPageProps = {
  params: { id: string };
};

export function generateStaticParams() {
  return products.map((product) => ({ id: product.id }));
}

export default function ProductPage({ params }: ProductPageProps) {
  const product = products.find((item) => item.id === params.id);

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
